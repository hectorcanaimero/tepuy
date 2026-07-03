import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:tepuy/core/db/app_database.dart';
import 'package:tepuy/core/domain/enums.dart';

import 'support.dart';

void main() {
  testWidgets('Collection: total, notas de tiempo/%, y filtro por favoritos', (
    tester,
  ) async {
    await pumpApp(
      tester,
      setup: (db) async {
        await db.into(db.userPuzzles).insert(
          UserPuzzlesCompanion.insert(
            id: 'salto-angel-facil-up',
            puzzleId: 'salto-angel-facil',
            status: PuzzleStatus.completed,
            bestTimeMs: const Value(102000),
            isFavorite: const Value(true),
          ),
        );
        await db.into(db.userPuzzles).insert(
          UserPuzzlesCompanion.insert(
            id: 'roraima-medio-up',
            puzzleId: 'roraima-medio',
            status: PuzzleStatus.inProgress,
            progressPct: const Value(0.6),
          ),
        );
      },
    );

    await tester.tap(find.text('Colección'));
    await tester.pumpAndSettle();

    // Header y total.
    expect(find.text('Mi Colección'), findsOneWidget);
    expect(find.text('2 puzzles'), findsOneWidget);

    // Las dos tarjetas con sus notas (tiempo / % completado).
    expect(find.text('Salto Ángel'), findsWidgets);
    expect(find.text('Monte Roraima'), findsOneWidget);
    expect(find.text('01:42'), findsWidgets); // nota de tarjeta + stat mejor tiempo
    expect(find.text('60% completado'), findsOneWidget); // en progreso

    // Filtro Favoritos → solo el favorito (Roraima desaparece).
    await tester.tap(find.text('Favoritos'));
    await tester.pumpAndSettle();
    expect(find.text('Monte Roraima'), findsNothing);
    expect(find.text('Salto Ángel'), findsWidgets);
  });
}
