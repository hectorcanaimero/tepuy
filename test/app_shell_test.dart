import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  testWidgets('el tab bar tiene 4 destinos y preserva navegación', (
    tester,
  ) async {
    await pumpApp(tester);

    // Tab bar presente con los 4 ítems.
    expect(find.byType(NavigationBar), findsOneWidget);
    for (final label in const ['Inicio', 'Diario', 'Colección', 'Perfil']) {
      expect(find.text(label), findsWidgets);
    }

    // Cambiar a Colección muestra su pantalla (placeholder) sin romper.
    await tester.tap(find.text('Colección'));
    await tester.pumpAndSettle();
    expect(find.text('Pantalla en construcción'), findsOneWidget);
    // El tab bar sigue ahí.
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
