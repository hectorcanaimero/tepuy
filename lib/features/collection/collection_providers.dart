import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/domain/enums.dart';
import '../puzzle/puzzle_providers.dart';

enum CollectionFilter { todos, completados, enProgreso, favoritos }

/// Un puzzle en la colección del usuario (progreso + lugar + dificultad).
class CollectionItem {
  const CollectionItem({
    required this.userPuzzle,
    required this.place,
    required this.difficulty,
  });

  final UserPuzzle userPuzzle;
  final Place place;
  final Difficulty difficulty;

  String get puzzleId => userPuzzle.puzzleId;
}

/// Colección del usuario (reactiva: se actualiza al marcar favoritos o jugar).
final collectionProvider = StreamProvider<List<CollectionItem>>((ref) async* {
  final places = {
    for (final p in await ref.watch(placeRepositoryProvider).getAll()) p.id: p,
  };
  final repo = ref.watch(userPuzzleRepositoryProvider);
  await for (final ups in repo.watchAll()) {
    final items = <CollectionItem>[];
    for (final up in ups) {
      final parsed = parsePuzzleId(up.puzzleId);
      final place = places[parsed.placeId];
      if (place == null) continue;
      items.add(
        CollectionItem(
          userPuzzle: up,
          place: place,
          difficulty: parsed.difficulty,
        ),
      );
    }
    yield items;
  }
});

class CollectionFilterNotifier extends Notifier<CollectionFilter> {
  @override
  CollectionFilter build() => CollectionFilter.todos;

  void select(CollectionFilter f) => state = f;
}

final collectionFilterProvider =
    NotifierProvider<CollectionFilterNotifier, CollectionFilter>(
      CollectionFilterNotifier.new,
    );
