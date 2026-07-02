import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/collection/data/user_puzzle_repository.dart';
import '../../features/places/data/place_repository.dart';
import '../../features/puzzle/data/puzzle_repository.dart';
import 'app_database.dart';

/// Instancia única de la DB local. En tests se sobrescribe con una en memoria.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final placeRepositoryProvider = Provider(
  (ref) => PlaceRepository(ref.watch(databaseProvider)),
);

final puzzleRepositoryProvider = Provider(
  (ref) => PuzzleRepository(ref.watch(databaseProvider)),
);

final userPuzzleRepositoryProvider = Provider(
  (ref) => UserPuzzleRepository(ref.watch(databaseProvider)),
);
