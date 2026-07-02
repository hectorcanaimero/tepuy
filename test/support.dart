import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tepuy/core/db/app_database.dart';
import 'package:tepuy/core/db/providers.dart';
import 'package:tepuy/main.dart';

/// Monta la app real con una DB en memoria (seeded) — sin tocar el filesystem.
Future<void> pumpApp(WidgetTester tester) async {
  GoogleFonts.config.allowRuntimeFetching = false;
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(
          AppDatabase(NativeDatabase.memory()),
        ),
      ],
      child: const TepuyApp(),
    ),
  );
  await tester.pumpAndSettle();
}
