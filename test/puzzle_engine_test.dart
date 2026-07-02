import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:tepuy/features/puzzle/engine/puzzle_engine.dart';

void main() {
  PuzzleBoard board({int cols = 3, int rows = 3}) => PuzzleBoard.generate(
    cols: cols,
    rows: rows,
    boardSize: const Size(300, 300),
    snapThreshold: 10,
  );

  test('genera N piezas con lengüetas complementarias entre vecinos', () {
    final b = board(cols: 3, rows: 3);
    expect(b.pieceCount, 9);

    // Bordes exteriores rectos.
    final topLeft = b.pieces.firstWhere((p) => p.col == 0 && p.row == 0);
    expect(topLeft.edges.top, Edge.flat);
    expect(topLeft.edges.left, Edge.flat);

    // El borde derecho de una pieza es complementario del izquierdo de su vecina.
    final a = b.pieces.firstWhere((p) => p.col == 0 && p.row == 1);
    final right = b.pieces.firstWhere((p) => p.col == 1 && p.row == 1);
    expect(a.edges.right, complementOf(right.edges.left));
  });

  test('gridForCount da el producto exacto por dificultad', () {
    expect(gridForCount(50), (cols: 5, rows: 10));
    expect(gridForCount(200).cols * gridForCount(200).rows, 200);
    expect(gridForCount(440).cols * gridForCount(440).rows, 440);
  });

  test('snap absoluto: soltar cerca del home coloca la pieza', () {
    final b = board();
    final p = b.pieces.first;
    p.pos = p.home + const Offset(6, 6); // dentro del umbral (10)
    expect(b.drop(p.index), isTrue);
    expect(p.placed, isTrue);
    expect(p.pos, p.home);
  });

  test('no hace snap si está lejos o rotada', () {
    final b = board();
    final p = b.pieces.first;
    p.pos = p.home + const Offset(50, 50);
    expect(b.drop(p.index), isFalse);
    expect(p.placed, isFalse);

    p.pos = p.home + const Offset(4, 4);
    p.rotation = 1; // orientación incorrecta
    expect(b.drop(p.index), isFalse);
  });

  test('merge: dos vecinos en relación correcta se unen y mueven juntos', () {
    final b = board();
    final left = b.pieces.firstWhere((p) => p.col == 0 && p.row == 0);
    final right = b.pieces.firstWhere((p) => p.col == 1 && p.row == 0);

    // Colocar right desplazado; left cerca de su relación correcta con right.
    right.pos = const Offset(200, 200);
    left.pos = right.pos + (left.home - right.home) + const Offset(5, 3);

    expect(b.drop(left.index), isTrue);
    expect(b.groupOf(left.index), b.groupOf(right.index));

    // Mover el grupo desplaza ambas.
    final before = right.pos;
    b.moveGroup(left.index, const Offset(10, 0));
    expect(right.pos, before + const Offset(10, 0));
  });

  test('isComplete cuando todas están colocadas', () {
    final b = board(cols: 2, rows: 2);
    expect(b.isComplete, isFalse);
    for (final p in b.pieces) {
      p.pos = p.home;
      expect(b.drop(p.index), isTrue);
    }
    expect(b.isComplete, isTrue);
  });

  test('serialize/applyState reanuda posiciones, rotación y colocado', () {
    final a = board();
    a.pieces[0].pos = const Offset(123, 45);
    a.pieces[0].rotation = 2;
    a.pieces[1].pos = a.pieces[1].home;
    a.drop(a.pieces[1].index); // placed
    final snapshot = a.serialize();

    final b = board();
    b.applyState(snapshot);
    expect(b.pieces[0].pos, const Offset(123, 45));
    expect(b.pieces[0].rotation, 2);
    expect(b.pieces[1].placed, isTrue);
  });
}
