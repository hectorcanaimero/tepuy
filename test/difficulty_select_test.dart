import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tepuy/core/db/app_database.dart';
import 'package:tepuy/core/domain/enums.dart';

import 'support.dart';

void main() {
  testWidgets('muestra las 5 dificultades y navega a jugar', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Jugar Ahora'));
    await tester.pumpAndSettle();

    // Novato (arriba) visible con su nº de piezas.
    expect(find.text('Novato'), findsOneWidget);
    expect(find.text('50 piezas'), findsOneWidget);

    // Experto está más abajo → hay que scrollear para encontrarlo.
    await tester.scrollUntilVisible(
      find.text('Experto'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Experto'), findsOneWidget);
    expect(find.text('440 piezas'), findsOneWidget);
    expect(find.text('Sin récord'), findsWidgets);

    // El CTA Jugar abre Puzzle Play. Play tiene Timer.periodic → pump (no
    // pumpAndSettle); pumpeamos hasta que la transición cubra Difficulty Select.
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('Seleccioná la dificultad'), findsNothing);
  });

  testWidgets('muestra el mejor tiempo cuando existe récord', (tester) async {
    // Récord de 1:42 (102000 ms) para Salto Ángel en Medio.
    await pumpApp(
      tester,
      setup: (db) async {
        await db
            .into(db.userPuzzles)
            .insert(
              UserPuzzlesCompanion.insert(
                id: 'salto-angel-medio-up',
                puzzleId: 'salto-angel-medio',
                status: PuzzleStatus.completed,
                bestTimeMs: const Value(102000),
              ),
            );
      },
    );

    // Salto Ángel es el lugar destacado → Jugar Ahora abre su Difficulty Select.
    await tester.tap(find.text('Jugar Ahora'));
    await tester.pumpAndSettle();

    expect(find.text('Mejor 01:42'), findsOneWidget);
  });
}
