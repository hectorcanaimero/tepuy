import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tepuy/main.dart';

void main() {
  testWidgets('el tab bar tiene 4 destinos y preserva navegación', (
    tester,
  ) async {
    GoogleFonts.config.allowRuntimeFetching = false;

    await tester.pumpWidget(const TepuyApp());
    await tester.pumpAndSettle();

    // Tab bar presente con los 4 ítems.
    expect(find.byType(NavigationBar), findsOneWidget);
    for (final label in const ['Inicio', 'Diario', 'Colección', 'Perfil']) {
      expect(find.text(label), findsWidgets);
    }

    // Arranca en Home.
    expect(find.text('TEPUY'), findsOneWidget);

    // Cambiar a Colección muestra su pantalla (placeholder) sin romper.
    await tester.tap(find.text('Colección'));
    await tester.pumpAndSettle();
    expect(find.text('Pantalla en construcción'), findsOneWidget);
    // El tab bar sigue ahí.
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
