import 'dart:math' as math;

import 'package:drift/drift.dart' show Value;

import '../../core/db/app_database.dart';
import '../../core/domain/enums.dart';
import '../collection/data/user_puzzle_repository.dart';
import 'engine/puzzle_engine.dart';

/// Estrellas por tiempo vs umbrales de la dificultad (oro < 1s/pieza,
/// plata < 2s/pieza, si no 1★).
int starsForTime(int elapsedMs, int pieceCount) {
  if (elapsedMs < pieceCount * 1000) return 3;
  if (elapsedMs < pieceCount * 2000) return 2;
  return 1;
}

/// Orquesta una partida: aplica movimientos al motor, persiste el estado del
/// tablero (para reanudar) y, al completar, guarda mejor tiempo + estrellas.
class PuzzleController {
  PuzzleController({
    required this.board,
    required this.puzzleId,
    required this.repo,
    required this.elapsedMs,
  });

  final PuzzleBoard board;
  final String puzzleId;
  final UserPuzzleRepository repo;

  /// Milisegundos transcurridos (lo provee la pantalla vía un cronómetro).
  final int Function() elapsedMs;

  bool completed = false;

  String get _userPuzzleId => '$puzzleId-up';

  /// Suelta el grupo de `index`; persiste y, si se completó, guarda el récord.
  /// Devuelve true si hubo snap/merge.
  Future<bool> drop(int index) async {
    final changed = board.drop(index);
    await persist();
    if (board.isComplete && !completed) {
      completed = true;
      await _saveRecord();
    }
    return changed;
  }

  /// Guarda el estado actual del tablero (para reanudar). Se llama en cada drop
  /// y también al pausar/salir de la app.
  Future<void> persist() async {
    final placed = board.pieces.where((p) => p.placed).length;
    await repo.save(
      UserPuzzlesCompanion.insert(
        id: _userPuzzleId,
        puzzleId: puzzleId,
        status: board.isComplete
            ? PuzzleStatus.completed
            : PuzzleStatus.inProgress,
        boardState: Value(board.serialize()),
        progressPct: Value(placed / board.pieceCount),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _saveRecord() async {
    final ms = elapsedMs();
    final existing = await repo.byPuzzle(puzzleId);
    final best = existing?.bestTimeMs == null
        ? ms
        : math.min(existing!.bestTimeMs!, ms);
    await repo.save(
      UserPuzzlesCompanion.insert(
        id: _userPuzzleId,
        puzzleId: puzzleId,
        status: PuzzleStatus.completed,
        bestTimeMs: Value(best),
        stars: Value(starsForTime(ms, board.pieceCount)),
        progressPct: const Value(1),
        boardState: Value(board.serialize()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
