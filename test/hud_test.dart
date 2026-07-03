import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  testWidgets('HUD: cronómetro, contador, restantes y herramientas', (
    tester,
  ) async {
    await pumpApp(tester);

    // Home → Difficulty Select.
    await tester.tap(find.text('Jugar Ahora'));
    await tester.pumpAndSettle();

    // Elegir Novato (50 piezas, más liviano) y jugar.
    await tester.tap(find.text('Novato'));
    await tester.pump();
    await tester.tap(find.byType(FilledButton));
    // La play screen tiene Timer.periodic → NO pumpAndSettle (colgaría).
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Herramientas presentes.
    expect(find.byIcon(Icons.lightbulb_outline), findsOneWidget);
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    expect(find.byIcon(Icons.zoom_in), findsOneWidget);
    expect(find.byIcon(Icons.zoom_out), findsOneWidget);
    expect(find.byIcon(Icons.undo), findsOneWidget);

    // Contador (0 colocadas / 50) y restantes.
    expect(find.textContaining('/ 50'), findsOneWidget);
    expect(find.text('50 restantes'), findsOneWidget);

    // Las herramientas responden sin romper: pista, preview, zoom.
    await tester.tap(find.byIcon(Icons.lightbulb_outline));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.zoom_in));
    await tester.pump();
    expect(find.byIcon(Icons.zoom_in), findsOneWidget); // sigue viva
  });
}
