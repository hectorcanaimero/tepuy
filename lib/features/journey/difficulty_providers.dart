import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/domain/enums.dart';

/// Un lugar por id (para Difficulty Select).
final placeByIdProvider = FutureProvider.family<Place?, String>(
  (ref, id) => ref.watch(placeRepositoryProvider).getById(id),
);

/// Mejor tiempo (ms) del usuario por dificultad para un lugar. `null` = sin récord.
final bestTimesProvider = FutureProvider.family<Map<Difficulty, int?>, String>((
  ref,
  placeId,
) async {
  final repo = ref.watch(userPuzzleRepositoryProvider);
  final result = <Difficulty, int?>{};
  for (final d in Difficulty.values) {
    final up = await repo.byPuzzle('$placeId-${d.name}');
    result[d] = up?.bestTimeMs;
  }
  return result;
});
