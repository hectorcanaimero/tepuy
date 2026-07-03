import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tepuy/core/db/app_database.dart';
import 'package:tepuy/core/domain/enums.dart';
import 'package:tepuy/core/router/app_router.dart';

import 'support.dart';

void main() {
  testWidgets('Reveal muestra info del lugar, resumen y guarda en colección', (
    tester,
  ) async {
    final db = await pumpApp(
      tester,
      setup: (db) async {
        await db
            .into(db.userPuzzles)
            .insert(
              UserPuzzlesCompanion.insert(
                id: 'salto-angel-facil-up',
                puzzleId: 'salto-angel-facil',
                status: PuzzleStatus.completed,
                bestTimeMs: const Value(102000),
                stars: const Value(3),
              ),
            );
      },
    );

    appRouter.go('/reveal/salto-angel-facil');
    await tester.pumpAndSettle();

    // Payoff (parte superior): encabezado, lugar y resumen.
    expect(find.text('ROMPECABEZAS COMPLETADO'), findsOneWidget);
    expect(find.text('Salto Ángel'), findsWidgets);
    expect(find.text('01:42'), findsOneWidget); // tiempo (102000 ms)
    expect(find.text('110'), findsOneWidget); // Fácil = 110 piezas
    expect(find.text('Sobre este lugar'), findsOneWidget);

    // Secciones y CTAs de más abajo (CustomScrollView lazy → hay que scrollear).
    final scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('Guardar en Colección'),
      300,
      scrollable: scrollable,
    );
    expect(find.text('Siguiente Rompecabezas'), findsOneWidget);

    // Guardar en Colección persiste y marca el botón.
    await tester.tap(find.text('Guardar en Colección'));
    await tester.pump();
    expect(find.text('Guardado en tu colección'), findsOneWidget);
    expect(find.byIcon(Icons.bookmark), findsOneWidget);

    // Persistió en la DB (no solo feedback visual).
    final up = await (db.select(db.userPuzzles)
          ..where((t) => t.puzzleId.equals('salto-angel-facil')))
        .getSingle();
    expect(up.isFavorite, isTrue);

    await tester.pump(const Duration(seconds: 5)); // flush timer del SnackBar
  });
}
