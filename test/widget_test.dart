import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

void main() {
  testWidgets('la app arranca en Home con datos del seed', (tester) async {
    await pumpApp(tester);

    // Título e i18n resuelto.
    expect(find.text('TEPUY'), findsWidgets);
    // El banner muestra el lugar destacado (del seed).
    expect(find.text('Salto Ángel'), findsWidgets);
  });
}
