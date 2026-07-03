import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/domain/enums.dart';
import '../puzzle/puzzle_providers.dart';

/// Datos del payoff post-partida.
class RevealData {
  const RevealData({
    required this.place,
    required this.difficulty,
    required this.bestTimeMs,
    required this.stars,
  });

  final Place place;
  final Difficulty difficulty;
  final int? bestTimeMs;
  final int stars;
}

final revealDataProvider = FutureProvider.family<RevealData?, String>((
  ref,
  puzzleId,
) async {
  final parsed = parsePuzzleId(puzzleId);
  final place = await ref.watch(placeRepositoryProvider).getById(parsed.placeId);
  if (place == null) return null;
  final up = await ref.watch(userPuzzleRepositoryProvider).byPuzzle(puzzleId);
  return RevealData(
    place: place,
    difficulty: parsed.difficulty,
    bestTimeMs: up?.bestTimeMs,
    stars: up?.stars ?? 0,
  );
});
