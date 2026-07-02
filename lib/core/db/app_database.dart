import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../domain/enums.dart';
import 'seed.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Base de datos local (única fuente de verdad, offline-first).
/// El seed corre en `onCreate` → una sola vez, al crear la DB.
@DriftDatabase(tables: [Places, Puzzles, UserPuzzles, Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'tepuy'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await seedDatabase(this);
    },
  );
}
