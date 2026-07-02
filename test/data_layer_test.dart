import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tepuy/core/db/app_database.dart';
import 'package:tepuy/core/db/providers.dart';
import 'package:tepuy/core/domain/enums.dart';
import 'package:tepuy/features/places/data/place_repository.dart';

void main() {
  test('Difficulty.medio.pieceCount == 200', () {
    expect(Difficulty.medio.pieceCount, 200);
  });

  test('el seed inserta lugares y un puzzle por dificultad', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    final places = await db.select(db.places).get();
    final puzzles = await db.select(db.puzzles).get();

    expect(places, isNotEmpty);
    // 5 dificultades por lugar.
    expect(puzzles.length, places.length * Difficulty.values.length);
    // Los datos llegan completos (facts deserializados).
    final angel = places.firstWhere((p) => p.id == 'salto-angel');
    expect(angel.facts, isNotEmpty);
    expect(angel.category, Category.naturaleza);
  });

  test('los repos entregan datos tipados vía provider', () async {
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory())),
      ],
    );
    addTearDown(container.dispose);

    final PlaceRepository repo = container.read(placeRepositoryProvider);
    final all = await repo.getAll();
    final montanas = await repo.byCategory(Category.montanas);

    expect(all, isNotEmpty);
    expect(montanas, isNotEmpty);
    expect(montanas.every((p) => p.category == Category.montanas), isTrue);
  });
}
