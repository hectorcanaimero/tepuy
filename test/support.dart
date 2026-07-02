import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tepuy/core/db/app_database.dart';
import 'package:tepuy/core/db/providers.dart';
import 'package:tepuy/core/router/app_router.dart';
import 'package:tepuy/main.dart';

/// Monta la app real con una DB en memoria (seeded). El callback opcional
/// `setup` permite sembrar datos extra (ej. un user_puzzle) antes de montar.
/// Devuelve la DB por si el test necesita inspeccionarla.
Future<AppDatabase> pumpApp(
  WidgetTester tester, {
  Future<void> Function(AppDatabase db)? setup,
}) async {
  GoogleFonts.config.allowRuntimeFetching = false;
  final db = AppDatabase(NativeDatabase.memory());
  if (setup != null) await setup(db);
  // appRouter es un singleton global; reseteá a Home para aislar cada test.
  appRouter.go('/');
  await tester.pumpWidget(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const TepuyApp(),
    ),
  );
  await tester.pumpAndSettle();
  return db;
}
