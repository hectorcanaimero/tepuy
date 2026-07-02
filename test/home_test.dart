import 'package:flutter_test/flutter_test.dart';
import 'package:tepuy/shared/widgets/puzzle_card.dart';

import 'support.dart';

void main() {
  testWidgets('Home muestra banner, populares y filtra por categoría', (
    tester,
  ) async {
    await pumpApp(tester);

    // Banner con el lugar destacado + CTA.
    expect(find.text('Salto Ángel'), findsWidgets);
    expect(find.text('Jugar Ahora'), findsOneWidget);

    // Populares: hay tarjetas, incluida Roraima (montañas).
    expect(find.byType(PuzzleCard), findsWidgets);
    expect(find.text('Monte Roraima'), findsOneWidget);

    // Filtrar por Playas oculta los lugares de otras categorías.
    await tester.tap(find.text('Playas'));
    await tester.pumpAndSettle();
    expect(find.text('Monte Roraima'), findsNothing);
    expect(find.byType(PuzzleCard), findsWidgets);
  });
}
