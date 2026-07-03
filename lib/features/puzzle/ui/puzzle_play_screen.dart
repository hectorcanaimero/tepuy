import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/providers.dart';
import '../../../core/theme/tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/format.dart';
import '../engine/piece_painter.dart';
import '../engine/puzzle_engine.dart';
import '../puzzle_controller.dart';
import '../puzzle_providers.dart';

/// Config de juego (el toggle real vive en Settings — Fase 2).
/// ponytail: rotación default OFF en MVP (sin Settings screen; jugabilidad).
/// El motor la soporta y está testeada; el doble-tap ya rota si se habilita.
const bool kRotationEnabled = false;

/// Pistas gratis por partida (PRD §10). Agotadas → deshabilitada en MVP; el ad
/// recompensado que repone es Fase 4.
const int kFreeHintsPerGame = 1;

class PuzzlePlayScreen extends ConsumerStatefulWidget {
  const PuzzlePlayScreen({super.key, required this.puzzleId});

  final String puzzleId;

  @override
  ConsumerState<PuzzlePlayScreen> createState() => _PuzzlePlayScreenState();
}

class _PuzzlePlayScreenState extends ConsumerState<PuzzlePlayScreen>
    with WidgetsBindingObserver {
  final _stopwatch = Stopwatch();
  Timer? _ticker; // refresca el cronómetro en pantalla
  Timer? _hintTimer;
  PuzzleBoard? _board;
  PuzzleController? _controller;
  int? _dragging;

  final _undoStack = <String>[];
  double _scale = 1;
  int _hintsUsed = 0;
  int? _hintIndex; // pieza cuya posición se está resaltando
  bool _showPreview = false;

  int get _placed => _board?.pieces.where((p) => p.placed).length ?? 0;
  int get _remaining => (_board?.pieceCount ?? 0) - _placed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      _stopwatch.stop();
      _controller?.persist();
    } else if (_board != null && !(_controller?.completed ?? false)) {
      _stopwatch.start();
    }
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
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _onDrop(int index) async {
    _undoStack.add(_board!.serialize());
    await _controller!.drop(index);
    setState(() => _dragging = null);
    if (_controller!.completed && mounted) {
      _stopwatch.stop();
      context.pushReplacement('/reveal/${widget.puzzleId}');
    }
  }

  void _undo() {
    if (_undoStack.isEmpty) return;
    setState(() => _board!.applyState(_undoStack.removeLast()));
    _controller!.persist();
  }

  void _useHint() {
    if (_hintsUsed >= kFreeHintsPerGame) return;
    final unplaced = _board!.pieces.where((p) => !p.placed).toList();
    if (unplaced.isEmpty) return;
    setState(() {
      _hintsUsed++;
      _hintIndex = unplaced[_stopwatch.elapsedMilliseconds % unplaced.length].index;
    });
    _hintTimer?.cancel();
    _hintTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _hintIndex = null);
    });
  }

  void _zoom(double factor) =>
      setState(() => _scale = (_scale * factor).clamp(0.6, 2.5));

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    _hintTimer?.cancel();
    _controller?.persist();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dataAsync = ref.watch(puzzleDataProvider(widget.puzzleId));
    return Scaffold(
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
              final baseHue = _hueFor(data.place.category.index);
              return Stack(
                fit: StackFit.expand,
                children: [
                  Transform.scale(
                    scale: _scale,
                    child: _Board(
                      board: _board!,
                      baseHue: baseHue,
                      dragging: _dragging,
                      hintIndex: _hintIndex,
                      onPanStart: (i) => setState(() => _dragging = i),
                      onPanUpdate: (i, delta) =>
                          setState(() => _board!.moveGroup(i, delta / _scale)),
                      onPanEnd: _onDrop,
                      onDoubleTap: kRotationEnabled
                          ? (i) => setState(() => _board!.rotateGroup(i))
                          : null,
                    ),
                  ),
                  if (_showPreview)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: CustomPaint(
                          painter: _PreviewPainter(_board!, baseHue),
                        ),
                      ),
                    ),
                  _TopBar(
                    title: data.place.name,
                    elapsed: formatDuration(_stopwatch.elapsedMilliseconds),
                    progress: l10n.piezasColocadas(_placed, _board!.pieceCount),
                    onBack: () => context.pop(),
                  ),
                  _ToolBar(
                    remaining: l10n.restantes(_remaining),
                    hintsLeft: kFreeHintsPerGame - _hintsUsed,
                    previewOn: _showPreview,
                    canUndo: _undoStack.isNotEmpty,
                    onHint: _useHint,
                    onPreview: () =>
                        setState(() => _showPreview = !_showPreview),
                    onZoomIn: () => _zoom(1.2),
                    onZoomOut: () => _zoom(1 / 1.2),
                    onUndo: _undo,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  double _hueFor(int categoryIndex) => (200 + categoryIndex * 30) % 360;
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.elapsed,
    required this.progress,
    required this.onBack,
  });

  final String title;
  final String elapsed;
  final String progress;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          color: p.overlay,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: onBack,
              ),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _Chip(icon: Icons.timer_outlined, label: elapsed),
              const SizedBox(width: 8),
              _Chip(icon: Icons.extension_outlined, label: progress),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white70),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

class _ToolBar extends StatelessWidget {
  const _ToolBar({
    required this.remaining,
    required this.hintsLeft,
    required this.previewOn,
    required this.canUndo,
    required this.onHint,
    required this.onPreview,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onUndo,
  });

  final String remaining;
  final int hintsLeft;
  final bool previewOn;
  final bool canUndo;
  final VoidCallback onHint;
  final VoidCallback onPreview;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          color: p.overlay,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(remaining, style: const TextStyle(color: Colors.white)),
              Row(
                children: [
                  IconButton(
                    tooltip: 'Pista',
                    icon: Badge(
                      isLabelVisible: hintsLeft > 0,
                      label: Text('$hintsLeft'),
                      child: const Icon(Icons.lightbulb_outline),
                    ),
                    color: Colors.white,
                    onPressed: hintsLeft > 0 ? onHint : null,
                  ),
                  IconButton(
                    tooltip: 'Vista previa',
                    icon: const Icon(Icons.visibility_outlined),
                    color: previewOn ? p.accentLight : Colors.white,
                    onPressed: onPreview,
                  ),
                  IconButton(
                    icon: const Icon(Icons.zoom_out),
                    color: Colors.white,
                    onPressed: onZoomOut,
                  ),
                  IconButton(
                    icon: const Icon(Icons.zoom_in),
                    color: Colors.white,
                    onPressed: onZoomIn,
                  ),
                  IconButton(
                    tooltip: 'Deshacer',
                    icon: const Icon(Icons.undo),
                    color: Colors.white,
                    onPressed: canUndo ? onUndo : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({
    required this.board,
    required this.baseHue,
    required this.dragging,
    required this.hintIndex,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onDoubleTap,
  });

  final PuzzleBoard board;
  final double baseHue;
  final int? dragging;
  final int? hintIndex;
  final ValueChanged<int> onPanStart;
  final void Function(int index, Offset delta) onPanUpdate;
  final ValueChanged<int> onPanEnd;
  final ValueChanged<int>? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
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
          // Marcador de pista: resalta el home de la pieza sugerida.
          if (hintIndex != null)
            Positioned(
              left: board.pieces[hintIndex!].home.dx,
              top: board.pieces[hintIndex!].home.dy,
              width: board.pieceSize.width,
              height: board.pieceSize.height,
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: palette.accent, width: 3),
                    color: palette.accentGlow,
                  ),
                ),
              ),
            ),
          for (final piece in ordered)
            AnimatedPositioned(
              key: ValueKey(piece.index),
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
                        border: palette.border,
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
  bool shouldRepaint(_PiecePainter old) => old.piece.rotation != piece.rotation;
}

/// Vista previa: dibuja todas las piezas en su home, translúcidas.
class _PreviewPainter extends CustomPainter {
  _PreviewPainter(this.board, this.baseHue);
  final PuzzleBoard board;
  final double baseHue;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in board.pieces) {
      canvas.save();
      canvas.translate(p.home.dx, p.home.dy);
      final path = piecePath(board.pieceSize, p.edges);
      canvas.drawPath(
        path,
        Paint()
          ..color = placeholderPieceColor(
            p,
            board.cols,
            board.rows,
            baseHue,
          ).withValues(alpha: 0.45),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_PreviewPainter old) => false;
}
