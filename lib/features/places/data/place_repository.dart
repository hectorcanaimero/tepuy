import '../../../core/db/app_database.dart';
import '../../../core/domain/enums.dart';

/// Acceso a lugares. Lee siempre de la DB local (offline-first).
class PlaceRepository {
  const PlaceRepository(this._db);

  final AppDatabase _db;

  Future<List<Place>> getAll() => _db.select(_db.places).get();

  Future<Place?> getById(String id) =>
      (_db.select(_db.places)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<Place>> byCategory(Category category) =>
      (_db.select(_db.places)..where((t) => t.category.equalsValue(category)))
          .get();

  Stream<List<Place>> watchAll() => _db.select(_db.places).watch();
}
