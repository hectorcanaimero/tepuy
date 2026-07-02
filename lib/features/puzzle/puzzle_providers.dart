import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/domain/enums.dart';

/// Datos para montar una partida. `savedState` (board_state) permite reanudar.
class PuzzleData {
  const PuzzleData({
    required this.place,
    required this.difficulty,
    required this.savedState,
  });

  final Place place;
  final Difficulty difficulty;
  final String? savedState;
}

/// El puzzleId es `{placeId}-{difficulty.name}`. Como el placeId puede tener
/// guiones, la dificultad es el último segmento.
({String placeId, Difficulty difficulty}) parsePuzzleId(String puzzleId) {
  final i = puzzleId.lastIndexOf('-');
  return (
    placeId: puzzleId.substring(0, i),
    difficulty: Difficulty.values.byName(puzzleId.substring(i + 1)),
  );
}

final puzzleDataProvider = FutureProvider.family<PuzzleData?, String>((
  ref,
  puzzleId,
) async {
  final parsed = parsePuzzleId(puzzleId);
  final place = await ref.watch(placeRepositoryProvider).getById(parsed.placeId);
  if (place == null) return null;
  final up = await ref.watch(userPuzzleRepositoryProvider).byPuzzle(puzzleId);
  return PuzzleData(
    place: place,
    difficulty: parsed.difficulty,
    savedState: up?.boardState,
  );
});
