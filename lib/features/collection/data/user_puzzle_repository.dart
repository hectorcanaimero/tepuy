import '../../../core/db/app_database.dart';

/// Progreso del usuario por puzzle. Escribe con `synced_at = null` (pendiente
/// de subir) — base del SyncEngine de la Fase 3.
class UserPuzzleRepository {
  const UserPuzzleRepository(this._db);

  final AppDatabase _db;

  Future<UserPuzzle?> byPuzzle(String puzzleId) =>
      (_db.select(_db.userPuzzles)..where((t) => t.puzzleId.equals(puzzleId)))
          .getSingleOrNull();

  Future<void> save(UserPuzzlesCompanion entry) =>
      _db.into(_db.userPuzzles).insertOnConflictUpdate(entry);

  Future<List<UserPuzzle>> favorites() =>
      (_db.select(_db.userPuzzles)..where((t) => t.isFavorite.equals(true)))
          .get();

  Stream<List<UserPuzzle>> watchAll() => _db.select(_db.userPuzzles).watch();
}
