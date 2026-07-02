import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  testWidgets('Difficulty Select muestra las 5 dificultades y navega a jugar', (
    tester,
  ) async {
    await pumpApp(tester);

    // Desde Home, tocar "Jugar Ahora" del banner abre Difficulty Select.
    await tester.tap(find.text('Jugar Ahora'));
    await tester.pumpAndSettle();

    // Las 5 dificultades con su nº de piezas.
    expect(find.text('Novato'), findsOneWidget);
    expect(find.text('Experto'), findsOneWidget);
    expect(find.text('50 piezas'), findsOneWidget);
    expect(find.text('440 piezas'), findsOneWidget);
    // Sin récord por defecto (nunca jugó).
    expect(find.text('Sin récord'), findsWidgets);

    // El CTA Jugar abre Puzzle Play (placeholder por ahora).
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(find.text('Pantalla en construcción'), findsOneWidget);
  });
}
