import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/domain/enums.dart';

/// Todos los lugares del catálogo (desde la DB local).
final placesProvider = FutureProvider<List<Place>>(
  (ref) => ref.watch(placeRepositoryProvider).getAll(),
);

/// Categoría seleccionada en Home. `null` = Todos.
class CategoryFilter extends Notifier<Category?> {
  @override
  Category? build() => null;

  void select(Category? category) => state = category;
}

final categoryFilterProvider = NotifierProvider<CategoryFilter, Category?>(
  CategoryFilter.new,
);
