import '../../../core/db/app_database.dart';

/// Acceso a puzzles (un lugar × una dificultad).
class PuzzleRepository {
  const PuzzleRepository(this._db);

  final AppDatabase _db;

  Future<List<Puzzle>> getAll() => _db.select(_db.puzzles).get();

  Future<Puzzle?> getById(String id) =>
      (_db.select(_db.puzzles)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<Puzzle>> byPlace(String placeId) =>
      (_db.select(_db.puzzles)..where((t) => t.placeId.equals(placeId))).get();
}
