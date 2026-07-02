import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tepuy/main.dart';

void main() {
  testWidgets('Home muestra el título e i18n resuelve (es-VE)', (tester) async {
    // Evita fetch de fuentes por red en el test (usa fallback del sistema).
    GoogleFonts.config.allowRuntimeFetching = false;

    await tester.pumpWidget(const TepuyApp());
    await tester.pumpAndSettle();

    // Título vía AppLocalizations, no hardcodeado.
    expect(find.text('TEPUY'), findsOneWidget);
    // Tagline en español.
    expect(find.textContaining('Armá'), findsOneWidget);
  });
}
