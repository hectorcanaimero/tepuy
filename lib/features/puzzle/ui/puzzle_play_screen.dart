import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/providers.dart';
import '../../../core/theme/tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../engine/piece_painter.dart';
import '../engine/puzzle_engine.dart';
import '../puzzle_controller.dart';
import '../puzzle_providers.dart';

/// Config de juego (el toggle real vive en Settings — Fase 2).
/// ponytail: rotación default OFF en MVP (sin Settings screen; jugabilidad).
/// El motor la soporta y está testeada; el doble-tap ya rota si se habilita.
const bool kRotationEnabled = false;

class PuzzlePlayScreen extends ConsumerStatefulWidget {
  const PuzzlePlayScreen({super.key, required this.puzzleId});

  final String puzzleId;

  @override
  ConsumerState<PuzzlePlayScreen> createState() => _PuzzlePlayScreenState();
}

class _PuzzlePlayScreenState extends ConsumerState<PuzzlePlayScreen>
    with WidgetsBindingObserver {
  final _stopwatch = Stopwatch();
  PuzzleBoard? _board;
  PuzzleController? _controller;
  int? _dragging; // índice de la pieza que se arrastra

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Guardar progreso al pausar/salir (Alcance del spec).
    if (state != AppLifecycleState.resumed) _controller?.persist();
  }

  void _applyInitialRotation(PuzzleBoard board) {
    if (!kRotationEnabled) return;
    for (final p in board.pieces) {
      p.rotation = (p.col * 3 + p.row * 2) % 4;
    }
  }

  void _ensureBoard(Size area, PuzzleData data) {
    if (_board != null) return;
    final grid = gridForCount(data.difficulty.pieceCount);
    final pw = area.width / grid.cols;
    final ph = area.height / grid.rows;
    final scatter = <Offset>[
      for (var i = 0; i < grid.cols * grid.rows; i++)
        Offset(
          ((i * 73) % 100) / 100 * (area.width - pw),
          ((i * 137) % 100) / 100 * (area.height - ph),
        ),
    ];
    final board = PuzzleBoard.generate(
      cols: grid.cols,
      rows: grid.rows,
      boardSize: area,
      snapThreshold: 0.35 * math.min(pw, ph),
      initialPositions: scatter,
    );
    _applyInitialRotation(board);
    if (data.savedState != null) {
      board.applyState(data.savedState!);
      // Reingreso a un puzzle ya completado → rejugar desde cero.
      if (board.isComplete) {
        board.reset(scatter);
        _applyInitialRotation(board);
      }
    }
    _board = board;
    _controller = PuzzleController(
      board: board,
      puzzleId: widget.puzzleId,
      repo: ref.read(userPuzzleRepositoryProvider),
      elapsedMs: () => _stopwatch.elapsedMilliseconds,
    );
    _stopwatch.start();
  }

  Future<void> _onDrop(int index) async {
    await _controller!.drop(index);
    setState(() => _dragging = null);
    if (_controller!.completed && mounted) {
      _stopwatch.stop();
      context.pushReplacement('/reveal/${widget.puzzleId}');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.persist();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dataAsync = ref.watch(puzzleDataProvider(widget.puzzleId));
    return Scaffold(
      appBar: AppBar(),
      body: dataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.errorCargarLugares)),
        data: (data) {
          if (data == null) {
            return Center(child: Text(l10n.errorCargarLugares));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              final area = Size(constraints.maxWidth, constraints.maxHeight);
              _ensureBoard(area, data);
              return _Board(
                board: _board!,
                baseHue: _hueFor(data.place.category.index),
                dragging: _dragging,
                onPanStart: (i) => setState(() => _dragging = i),
                onPanUpdate: (i, delta) =>
                    setState(() => _board!.moveGroup(i, delta)),
                onPanEnd: _onDrop,
                onDoubleTap: kRotationEnabled
                    ? (i) => setState(() => _board!.rotateGroup(i))
                    : null,
              );
            },
          );
        },
      ),
    );
  }

  double _hueFor(int categoryIndex) => (200 + categoryIndex * 30) % 360;
}

class _Board extends StatelessWidget {
  const _Board({
    required this.board,
    required this.baseHue,
    required this.dragging,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onDoubleTap,
  });

  final PuzzleBoard board;
  final double baseHue;
  final int? dragging;
  final ValueChanged<int> onPanStart;
  final void Function(int index, Offset delta) onPanUpdate;
  final ValueChanged<int> onPanEnd;
  final ValueChanged<int>? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    final border = AppPalette.of(context).border;
    // z-order: colocadas al fondo, sin colocar encima, la arrastrada última.
    final ordered = [...board.pieces]
      ..sort((a, b) {
        int rank(Piece p) => p.placed ? 0 : 1;
        final byPlaced = rank(a).compareTo(rank(b));
        if (byPlaced != 0) return byPlaced;
        final da = board.groupOf(a.index) == dragging;
        final db = board.groupOf(b.index) == dragging;
        return (da ? 1 : 0).compareTo(db ? 1 : 0);
      });

    return ClipRect(
      child: Stack(
        children: [
          for (final piece in ordered)
            AnimatedPositioned(
              // Key por identidad de pieza: la lista se reordena por placed/dragging,
              // sin key la animación implícita se aplicaría a la pieza equivocada.
              key: ValueKey(piece.index),
              // Instantáneo mientras se arrastra; animado al soltar (snap).
              duration: board.groupOf(piece.index) == dragging
                  ? Duration.zero
                  : const Duration(milliseconds: 130),
              curve: Curves.easeOut,
              left: piece.pos.dx,
              top: piece.pos.dy,
              width: board.pieceSize.width,
              height: board.pieceSize.height,
              child: IgnorePointer(
                ignoring: piece.placed,
                child: GestureDetector(
                  onPanStart: (_) => onPanStart(board.groupOf(piece.index)),
                  onPanUpdate: (d) =>
                      onPanUpdate(board.groupOf(piece.index), d.delta),
                  onPanEnd: (_) => onPanEnd(board.groupOf(piece.index)),
                  onDoubleTap: onDoubleTap == null
                      ? null
                      : () => onDoubleTap!(board.groupOf(piece.index)),
                  child: Transform.rotate(
                    angle: piece.rotation * math.pi / 2,
                    child: CustomPaint(
                      painter: _PiecePainter(
                        piece: piece,
                        cols: board.cols,
                        rows: board.rows,
                        baseHue: baseHue,
                        border: border,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PiecePainter extends CustomPainter {
  _PiecePainter({
    required this.piece,
    required this.cols,
    required this.rows,
    required this.baseHue,
    required this.border,
  });

  final Piece piece;
  final int cols;
  final int rows;
  final double baseHue;
  final Color border;

  @override
  void paint(Canvas canvas, Size size) {
    final path = piecePath(size, piece.edges);
    canvas.drawPath(
      path,
      Paint()..color = placeholderPieceColor(piece, cols, rows, baseHue),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = border,
    );
  }

  @override
  bool shouldRepaint(_PiecePainter old) =>
      old.piece.rotation != piece.rotation;
}
