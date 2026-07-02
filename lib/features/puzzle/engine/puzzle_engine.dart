import 'dart:convert';
import 'dart:ui';

/// Tipo de borde de una pieza. Los bordes interiores son complementarios entre
/// vecinos; el borde exterior del puzzle es recto.
enum Edge { flat, tabOut, tabIn }

Edge complementOf(Edge e) => switch (e) {
  Edge.tabOut => Edge.tabIn,
  Edge.tabIn => Edge.tabOut,
  Edge.flat => Edge.flat,
};

/// Los 4 bordes de una pieza (top, right, bottom, left).
class PieceEdges {
  const PieceEdges(this.top, this.right, this.bottom, this.left);
  final Edge top;
  final Edge right;
  final Edge bottom;
  final Edge left;
}

/// Una pieza del rompecabezas. `home` es su posición correcta (esquina sup-izq);
/// `pos` es la actual. `rotation` en cuartos de vuelta (0..3). El snap requiere
/// orientación correcta (rotation == 0).
class Piece {
  Piece({
    required this.index,
    required this.col,
    required this.row,
    required this.edges,
    required this.home,
    required this.pos,
    this.rotation = 0,
    this.placed = false,
  });

  final int index;
  final int col;
  final int row;
  final PieceEdges edges;
  final Offset home;
  Offset pos;
  int rotation;
  bool placed;
}

/// Motor del rompecabezas: genera la grilla y sus lengüetas, gestiona grupos
/// (union-find), snap magnético y detección de completado. Dart puro (sin
/// Flutter) → totalmente testeable sin render.
class PuzzleBoard {
  PuzzleBoard._({
    required this.cols,
    required this.rows,
    required this.pieceSize,
    required this.pieces,
    required this.snapThreshold,
  }) : _parent = List<int>.generate(pieces.length, (i) => i);

  final int cols;
  final int rows;
  final Size pieceSize;
  final List<Piece> pieces;
  final double snapThreshold;
  final List<int> _parent;

  int get pieceCount => pieces.length;

  // --- Generación determinística de la topología de lengüetas ---
  static Edge _vSeam(int c, int r) =>
      ((c * 2 + r * 3) % 2 == 0) ? Edge.tabOut : Edge.tabIn;
  static Edge _hSeam(int c, int r) =>
      ((c * 3 + r * 2) % 2 == 0) ? Edge.tabOut : Edge.tabIn;

  /// Genera una grilla `cols × rows` sobre un tablero de `boardSize`. Las piezas
  /// nacen en `initialPositions` (o en su `home` si no se pasan).
  factory PuzzleBoard.generate({
    required int cols,
    required int rows,
    required Size boardSize,
    double snapThreshold = 20,
    List<Offset>? initialPositions,
  }) {
    final pw = boardSize.width / cols;
    final ph = boardSize.height / rows;
    final pieces = <Piece>[];
    var index = 0;
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final top = r == 0 ? Edge.flat : complementOf(_hSeam(c, r - 1));
        final bottom = r == rows - 1 ? Edge.flat : _hSeam(c, r);
        final left = c == 0 ? Edge.flat : complementOf(_vSeam(c - 1, r));
        final right = c == cols - 1 ? Edge.flat : _vSeam(c, r);
        final home = Offset(c * pw, r * ph);
        pieces.add(
          Piece(
            index: index,
            col: c,
            row: r,
            edges: PieceEdges(top, right, bottom, left),
            home: home,
            pos: initialPositions != null ? initialPositions[index] : home,
          ),
        );
        index++;
      }
    }
    return PuzzleBoard._(
      cols: cols,
      rows: rows,
      pieceSize: Size(pw, ph),
      pieces: pieces,
      snapThreshold: snapThreshold,
    );
  }

  // --- Union-find de grupos ---
  int groupOf(int i) {
    var root = i;
    while (_parent[root] != root) {
      root = _parent[root];
    }
    // Path compression.
    var cur = i;
    while (_parent[cur] != root) {
      final next = _parent[cur];
      _parent[cur] = root;
      cur = next;
    }
    return root;
  }

  void _union(int a, int b) {
    final ra = groupOf(a);
    final rb = groupOf(b);
    if (ra != rb) _parent[rb] = ra;
  }

  List<Piece> groupMembers(int i) {
    final root = groupOf(i);
    return [for (final p in pieces) if (groupOf(p.index) == root) p];
  }

  /// Mueve el grupo de `index` por `delta` (piezas no colocadas).
  void moveGroup(int index, Offset delta) {
    for (final p in groupMembers(index)) {
      if (!p.placed) p.pos += delta;
    }
  }

  /// Rota una pieza (y su grupo) un cuarto de vuelta.
  void rotateGroup(int index) {
    for (final p in groupMembers(index)) {
      if (!p.placed) p.rotation = (p.rotation + 1) % 4;
    }
  }

  /// Suelta el grupo de `index`: intenta (1) snap absoluto a `home` si alguna
  /// pieza cae cerca de su lugar con orientación correcta, o (2) unir con un
  /// vecino correcto. Devuelve true si hubo snap o merge.
  bool drop(int index) {
    final members = groupMembers(index);
    // (1) Snap absoluto a home.
    final allUpright = members.every((p) => p.rotation == 0);
    if (allUpright) {
      for (final p in members) {
        if ((p.pos - p.home).distance <= snapThreshold) {
          for (final m in members) {
            m.pos = m.home;
            m.placed = true;
          }
          return true;
        }
      }
    }
    // (2) Merge con vecino correcto.
    for (final m in members) {
      if (m.rotation != 0) continue;
      for (final n in pieces) {
        if (groupOf(n.index) == groupOf(m.index)) continue;
        if (n.rotation != 0) continue;
        if (!_areNeighbors(m, n)) continue;
        final expected = m.home - n.home; // relación correcta m respecto a n
        final actual = m.pos - n.pos;
        if ((actual - expected).distance <= snapThreshold) {
          // Alinear el grupo arrastrado a n y unir.
          final shift = (n.pos + expected) - m.pos;
          for (final g in members) {
            g.pos += shift;
          }
          _union(n.index, m.index);
          return true;
        }
      }
    }
    return false;
  }

  bool _areNeighbors(Piece a, Piece b) {
    final dc = (a.col - b.col).abs();
    final dr = (a.row - b.row).abs();
    return (dc == 1 && dr == 0) || (dc == 0 && dr == 1);
  }

  bool get isComplete => pieces.every((p) => p.placed);

  // --- Persistencia (board_state) ---
  String serialize() => jsonEncode({
    'cols': cols,
    'rows': rows,
    'w': pieceSize.width,
    'h': pieceSize.height,
    'parent': _parent,
    'pieces': [
      for (final p in pieces)
        {'x': p.pos.dx, 'y': p.pos.dy, 'r': p.rotation, 'p': p.placed},
    ],
  });

  /// Aplica un estado serializado (mismo cols×rows). La topología se regenera
  /// determinísticamente, así que solo restauramos posiciones/rotación/estado.
  void applyState(String json) {
    final data = jsonDecode(json) as Map<String, dynamic>;
    final list = data['pieces'] as List;
    for (var i = 0; i < pieces.length && i < list.length; i++) {
      final s = list[i] as Map<String, dynamic>;
      pieces[i].pos = Offset((s['x'] as num).toDouble(), (s['y'] as num).toDouble());
      pieces[i].rotation = s['r'] as int;
      pieces[i].placed = s['p'] as bool;
    }
    final parent = (data['parent'] as List).cast<int>();
    for (var i = 0; i < _parent.length && i < parent.length; i++) {
      _parent[i] = parent[i];
    }
  }
}

/// Grilla (cols × rows) por dificultad — producto exacto = nº de piezas.
({int cols, int rows}) gridForCount(int pieceCount) => switch (pieceCount) {
  50 => (cols: 5, rows: 10),
  110 => (cols: 10, rows: 11),
  200 => (cols: 10, rows: 20),
  300 => (cols: 15, rows: 20),
  440 => (cols: 20, rows: 22),
  _ => (cols: 4, rows: (pieceCount / 4).ceil()),
};
