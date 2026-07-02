import 'dart:convert';

import 'package:drift/drift.dart';

import '../domain/enums.dart';

/// Un dato clave del lugar (métrica + valor). Se guarda como JSON en `facts`.
class Fact {
  const Fact(this.label, this.value);

  final String label;
  final String value;

  Map<String, dynamic> toJson() => {'label': label, 'value': value};

  factory Fact.fromJson(Map<String, dynamic> j) =>
      Fact(j['label'] as String, j['value'] as String);
}

/// Convierte `List<Fact>` ↔ columna TEXT (JSON).
class FactsConverter extends TypeConverter<List<Fact>, String> {
  const FactsConverter();

  @override
  List<Fact> fromSql(String fromDb) => (jsonDecode(fromDb) as List)
      .map((e) => Fact.fromJson(e as Map<String, dynamic>))
      .toList();

  @override
  String toSql(List<Fact> value) =>
      jsonEncode(value.map((f) => f.toJson()).toList());
}

@DataClassName('Place')
class Places extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get location => text()();
  TextColumn get state => text()();
  IntColumn get category => intEnum<Category>()();
  TextColumn get description => text()();
  TextColumn get facts => text().map(const FactsConverter())();
  TextColumn get didYouKnow => text()();
  TextColumn get imagePath => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Un puzzle = un lugar en una dificultad. El nº de piezas se deriva de
/// `Difficulty.pieceCount` (no se guarda redundante).
@DataClassName('Puzzle')
class Puzzles extends Table {
  TextColumn get id => text()();
  TextColumn get placeId => text().references(Places, #id)();
  IntColumn get difficulty => intEnum<Difficulty>()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('UserPuzzle')
class UserPuzzles extends Table {
  TextColumn get id => text()();
  TextColumn get puzzleId => text().references(Puzzles, #id)();
  IntColumn get status => intEnum<PuzzleStatus>()();
  IntColumn get bestTimeMs => integer().nullable()();
  IntColumn get stars => integer().withDefault(const Constant(0))();
  RealColumn get progressPct => real().withDefault(const Constant(0))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  /// Estado del tablero (JSON) para reanudar partidas. Su uso es del spec 05.
  TextColumn get boardState => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  /// null = pendiente de subir. Base del SyncEngine (Fase 3).
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AppUser')
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get username => text()();
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  TextColumn get rank => text().withDefault(const Constant('Novato'))();
  IntColumn get streakDays => integer().withDefault(const Constant(0))();
  IntColumn get coins => integer().withDefault(const Constant(0))();
  DateTimeColumn get joinedAt => dateTime().withDefault(currentDateAndTime)();

  /// Stats agregadas (JSON). Se llena en Fase 2.
  TextColumn get stats => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
