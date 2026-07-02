// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlacesTable extends Places with TableInfo<$PlacesTable, Place> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Category, int> category =
      GeneratedColumn<int>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Category>($PlacesTable.$convertercategory);
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<Fact>, String> facts =
      GeneratedColumn<String>(
        'facts',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<Fact>>($PlacesTable.$converterfacts);
  static const VerificationMeta _didYouKnowMeta = const VerificationMeta(
    'didYouKnow',
  );
  @override
  late final GeneratedColumn<String> didYouKnow = GeneratedColumn<String>(
    'did_you_know',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    location,
    state,
    category,
    description,
    facts,
    didYouKnow,
    imagePath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'places';
  @override
  VerificationContext validateIntegrity(
    Insertable<Place> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('did_you_know')) {
      context.handle(
        _didYouKnowMeta,
        didYouKnow.isAcceptableOrUnknown(
          data['did_you_know']!,
          _didYouKnowMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_didYouKnowMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Place map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Place(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      category: $PlacesTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}category'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      facts: $PlacesTable.$converterfacts.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}facts'],
        )!,
      ),
      didYouKnow: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}did_you_know'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Category, int, int> $convertercategory =
      const EnumIndexConverter<Category>(Category.values);
  static TypeConverter<List<Fact>, String> $converterfacts =
      const FactsConverter();
}

class Place extends DataClass implements Insertable<Place> {
  final String id;
  final String name;
  final String location;
  final String state;
  final Category category;
  final String description;
  final List<Fact> facts;
  final String didYouKnow;
  final String imagePath;
  final DateTime createdAt;
  const Place({
    required this.id,
    required this.name,
    required this.location,
    required this.state,
    required this.category,
    required this.description,
    required this.facts,
    required this.didYouKnow,
    required this.imagePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['location'] = Variable<String>(location);
    map['state'] = Variable<String>(state);
    {
      map['category'] = Variable<int>(
        $PlacesTable.$convertercategory.toSql(category),
      );
    }
    map['description'] = Variable<String>(description);
    {
      map['facts'] = Variable<String>(
        $PlacesTable.$converterfacts.toSql(facts),
      );
    }
    map['did_you_know'] = Variable<String>(didYouKnow);
    map['image_path'] = Variable<String>(imagePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlacesCompanion toCompanion(bool nullToAbsent) {
    return PlacesCompanion(
      id: Value(id),
      name: Value(name),
      location: Value(location),
      state: Value(state),
      category: Value(category),
      description: Value(description),
      facts: Value(facts),
      didYouKnow: Value(didYouKnow),
      imagePath: Value(imagePath),
      createdAt: Value(createdAt),
    );
  }

  factory Place.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Place(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      location: serializer.fromJson<String>(json['location']),
      state: serializer.fromJson<String>(json['state']),
      category: $PlacesTable.$convertercategory.fromJson(
        serializer.fromJson<int>(json['category']),
      ),
      description: serializer.fromJson<String>(json['description']),
      facts: serializer.fromJson<List<Fact>>(json['facts']),
      didYouKnow: serializer.fromJson<String>(json['didYouKnow']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'location': serializer.toJson<String>(location),
      'state': serializer.toJson<String>(state),
      'category': serializer.toJson<int>(
        $PlacesTable.$convertercategory.toJson(category),
      ),
      'description': serializer.toJson<String>(description),
      'facts': serializer.toJson<List<Fact>>(facts),
      'didYouKnow': serializer.toJson<String>(didYouKnow),
      'imagePath': serializer.toJson<String>(imagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Place copyWith({
    String? id,
    String? name,
    String? location,
    String? state,
    Category? category,
    String? description,
    List<Fact>? facts,
    String? didYouKnow,
    String? imagePath,
    DateTime? createdAt,
  }) => Place(
    id: id ?? this.id,
    name: name ?? this.name,
    location: location ?? this.location,
    state: state ?? this.state,
    category: category ?? this.category,
    description: description ?? this.description,
    facts: facts ?? this.facts,
    didYouKnow: didYouKnow ?? this.didYouKnow,
    imagePath: imagePath ?? this.imagePath,
    createdAt: createdAt ?? this.createdAt,
  );
  Place copyWithCompanion(PlacesCompanion data) {
    return Place(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      location: data.location.present ? data.location.value : this.location,
      state: data.state.present ? data.state.value : this.state,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      facts: data.facts.present ? data.facts.value : this.facts,
      didYouKnow: data.didYouKnow.present
          ? data.didYouKnow.value
          : this.didYouKnow,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Place(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('state: $state, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('facts: $facts, ')
          ..write('didYouKnow: $didYouKnow, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    location,
    state,
    category,
    description,
    facts,
    didYouKnow,
    imagePath,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Place &&
          other.id == this.id &&
          other.name == this.name &&
          other.location == this.location &&
          other.state == this.state &&
          other.category == this.category &&
          other.description == this.description &&
          other.facts == this.facts &&
          other.didYouKnow == this.didYouKnow &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt);
}

class PlacesCompanion extends UpdateCompanion<Place> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> location;
  final Value<String> state;
  final Value<Category> category;
  final Value<String> description;
  final Value<List<Fact>> facts;
  final Value<String> didYouKnow;
  final Value<String> imagePath;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.location = const Value.absent(),
    this.state = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.facts = const Value.absent(),
    this.didYouKnow = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlacesCompanion.insert({
    required String id,
    required String name,
    required String location,
    required String state,
    required Category category,
    required String description,
    required List<Fact> facts,
    required String didYouKnow,
    required String imagePath,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       location = Value(location),
       state = Value(state),
       category = Value(category),
       description = Value(description),
       facts = Value(facts),
       didYouKnow = Value(didYouKnow),
       imagePath = Value(imagePath);
  static Insertable<Place> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? location,
    Expression<String>? state,
    Expression<int>? category,
    Expression<String>? description,
    Expression<String>? facts,
    Expression<String>? didYouKnow,
    Expression<String>? imagePath,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      if (state != null) 'state': state,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (facts != null) 'facts': facts,
      if (didYouKnow != null) 'did_you_know': didYouKnow,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlacesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? location,
    Value<String>? state,
    Value<Category>? category,
    Value<String>? description,
    Value<List<Fact>>? facts,
    Value<String>? didYouKnow,
    Value<String>? imagePath,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      state: state ?? this.state,
      category: category ?? this.category,
      description: description ?? this.description,
      facts: facts ?? this.facts,
      didYouKnow: didYouKnow ?? this.didYouKnow,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(
        $PlacesTable.$convertercategory.toSql(category.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (facts.present) {
      map['facts'] = Variable<String>(
        $PlacesTable.$converterfacts.toSql(facts.value),
      );
    }
    if (didYouKnow.present) {
      map['did_you_know'] = Variable<String>(didYouKnow.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('state: $state, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('facts: $facts, ')
          ..write('didYouKnow: $didYouKnow, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PuzzlesTable extends Puzzles with TableInfo<$PuzzlesTable, Puzzle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PuzzlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<String> placeId = GeneratedColumn<String>(
    'place_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES places (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Difficulty, int> difficulty =
      GeneratedColumn<int>(
        'difficulty',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Difficulty>($PuzzlesTable.$converterdifficulty);
  @override
  List<GeneratedColumn> get $columns => [id, placeId, difficulty];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'puzzles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Puzzle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Puzzle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Puzzle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      placeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_id'],
      )!,
      difficulty: $PuzzlesTable.$converterdifficulty.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}difficulty'],
        )!,
      ),
    );
  }

  @override
  $PuzzlesTable createAlias(String alias) {
    return $PuzzlesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Difficulty, int, int> $converterdifficulty =
      const EnumIndexConverter<Difficulty>(Difficulty.values);
}

class Puzzle extends DataClass implements Insertable<Puzzle> {
  final String id;
  final String placeId;
  final Difficulty difficulty;
  const Puzzle({
    required this.id,
    required this.placeId,
    required this.difficulty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['place_id'] = Variable<String>(placeId);
    {
      map['difficulty'] = Variable<int>(
        $PuzzlesTable.$converterdifficulty.toSql(difficulty),
      );
    }
    return map;
  }

  PuzzlesCompanion toCompanion(bool nullToAbsent) {
    return PuzzlesCompanion(
      id: Value(id),
      placeId: Value(placeId),
      difficulty: Value(difficulty),
    );
  }

  factory Puzzle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Puzzle(
      id: serializer.fromJson<String>(json['id']),
      placeId: serializer.fromJson<String>(json['placeId']),
      difficulty: $PuzzlesTable.$converterdifficulty.fromJson(
        serializer.fromJson<int>(json['difficulty']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'placeId': serializer.toJson<String>(placeId),
      'difficulty': serializer.toJson<int>(
        $PuzzlesTable.$converterdifficulty.toJson(difficulty),
      ),
    };
  }

  Puzzle copyWith({String? id, String? placeId, Difficulty? difficulty}) =>
      Puzzle(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        difficulty: difficulty ?? this.difficulty,
      );
  Puzzle copyWithCompanion(PuzzlesCompanion data) {
    return Puzzle(
      id: data.id.present ? data.id.value : this.id,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Puzzle(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, placeId, difficulty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Puzzle &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.difficulty == this.difficulty);
}

class PuzzlesCompanion extends UpdateCompanion<Puzzle> {
  final Value<String> id;
  final Value<String> placeId;
  final Value<Difficulty> difficulty;
  final Value<int> rowid;
  const PuzzlesCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PuzzlesCompanion.insert({
    required String id,
    required String placeId,
    required Difficulty difficulty,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       placeId = Value(placeId),
       difficulty = Value(difficulty);
  static Insertable<Puzzle> custom({
    Expression<String>? id,
    Expression<String>? placeId,
    Expression<int>? difficulty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (difficulty != null) 'difficulty': difficulty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PuzzlesCompanion copyWith({
    Value<String>? id,
    Value<String>? placeId,
    Value<Difficulty>? difficulty,
    Value<int>? rowid,
  }) {
    return PuzzlesCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      difficulty: difficulty ?? this.difficulty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<String>(placeId.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(
        $PuzzlesTable.$converterdifficulty.toSql(difficulty.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PuzzlesCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('difficulty: $difficulty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPuzzlesTable extends UserPuzzles
    with TableInfo<$UserPuzzlesTable, UserPuzzle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPuzzlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _puzzleIdMeta = const VerificationMeta(
    'puzzleId',
  );
  @override
  late final GeneratedColumn<String> puzzleId = GeneratedColumn<String>(
    'puzzle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES puzzles (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PuzzleStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<PuzzleStatus>($UserPuzzlesTable.$converterstatus);
  static const VerificationMeta _bestTimeMsMeta = const VerificationMeta(
    'bestTimeMs',
  );
  @override
  late final GeneratedColumn<int> bestTimeMs = GeneratedColumn<int>(
    'best_time_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _starsMeta = const VerificationMeta('stars');
  @override
  late final GeneratedColumn<int> stars = GeneratedColumn<int>(
    'stars',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _progressPctMeta = const VerificationMeta(
    'progressPct',
  );
  @override
  late final GeneratedColumn<double> progressPct = GeneratedColumn<double>(
    'progress_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _boardStateMeta = const VerificationMeta(
    'boardState',
  );
  @override
  late final GeneratedColumn<String> boardState = GeneratedColumn<String>(
    'board_state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    puzzleId,
    status,
    bestTimeMs,
    stars,
    progressPct,
    isFavorite,
    boardState,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_puzzles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPuzzle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('puzzle_id')) {
      context.handle(
        _puzzleIdMeta,
        puzzleId.isAcceptableOrUnknown(data['puzzle_id']!, _puzzleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_puzzleIdMeta);
    }
    if (data.containsKey('best_time_ms')) {
      context.handle(
        _bestTimeMsMeta,
        bestTimeMs.isAcceptableOrUnknown(
          data['best_time_ms']!,
          _bestTimeMsMeta,
        ),
      );
    }
    if (data.containsKey('stars')) {
      context.handle(
        _starsMeta,
        stars.isAcceptableOrUnknown(data['stars']!, _starsMeta),
      );
    }
    if (data.containsKey('progress_pct')) {
      context.handle(
        _progressPctMeta,
        progressPct.isAcceptableOrUnknown(
          data['progress_pct']!,
          _progressPctMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('board_state')) {
      context.handle(
        _boardStateMeta,
        boardState.isAcceptableOrUnknown(data['board_state']!, _boardStateMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPuzzle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPuzzle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      puzzleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzle_id'],
      )!,
      status: $UserPuzzlesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      bestTimeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_time_ms'],
      ),
      stars: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stars'],
      )!,
      progressPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress_pct'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      boardState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}board_state'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $UserPuzzlesTable createAlias(String alias) {
    return $UserPuzzlesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PuzzleStatus, int, int> $converterstatus =
      const EnumIndexConverter<PuzzleStatus>(PuzzleStatus.values);
}

class UserPuzzle extends DataClass implements Insertable<UserPuzzle> {
  final String id;
  final String puzzleId;
  final PuzzleStatus status;
  final int? bestTimeMs;
  final int stars;
  final double progressPct;
  final bool isFavorite;

  /// Estado del tablero (JSON) para reanudar partidas. Su uso es del spec 05.
  final String? boardState;
  final DateTime updatedAt;

  /// null = pendiente de subir. Base del SyncEngine (Fase 3).
  final DateTime? syncedAt;
  const UserPuzzle({
    required this.id,
    required this.puzzleId,
    required this.status,
    this.bestTimeMs,
    required this.stars,
    required this.progressPct,
    required this.isFavorite,
    this.boardState,
    required this.updatedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['puzzle_id'] = Variable<String>(puzzleId);
    {
      map['status'] = Variable<int>(
        $UserPuzzlesTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || bestTimeMs != null) {
      map['best_time_ms'] = Variable<int>(bestTimeMs);
    }
    map['stars'] = Variable<int>(stars);
    map['progress_pct'] = Variable<double>(progressPct);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || boardState != null) {
      map['board_state'] = Variable<String>(boardState);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  UserPuzzlesCompanion toCompanion(bool nullToAbsent) {
    return UserPuzzlesCompanion(
      id: Value(id),
      puzzleId: Value(puzzleId),
      status: Value(status),
      bestTimeMs: bestTimeMs == null && nullToAbsent
          ? const Value.absent()
          : Value(bestTimeMs),
      stars: Value(stars),
      progressPct: Value(progressPct),
      isFavorite: Value(isFavorite),
      boardState: boardState == null && nullToAbsent
          ? const Value.absent()
          : Value(boardState),
      updatedAt: Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory UserPuzzle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPuzzle(
      id: serializer.fromJson<String>(json['id']),
      puzzleId: serializer.fromJson<String>(json['puzzleId']),
      status: $UserPuzzlesTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      bestTimeMs: serializer.fromJson<int?>(json['bestTimeMs']),
      stars: serializer.fromJson<int>(json['stars']),
      progressPct: serializer.fromJson<double>(json['progressPct']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      boardState: serializer.fromJson<String?>(json['boardState']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'puzzleId': serializer.toJson<String>(puzzleId),
      'status': serializer.toJson<int>(
        $UserPuzzlesTable.$converterstatus.toJson(status),
      ),
      'bestTimeMs': serializer.toJson<int?>(bestTimeMs),
      'stars': serializer.toJson<int>(stars),
      'progressPct': serializer.toJson<double>(progressPct),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'boardState': serializer.toJson<String?>(boardState),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  UserPuzzle copyWith({
    String? id,
    String? puzzleId,
    PuzzleStatus? status,
    Value<int?> bestTimeMs = const Value.absent(),
    int? stars,
    double? progressPct,
    bool? isFavorite,
    Value<String?> boardState = const Value.absent(),
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => UserPuzzle(
    id: id ?? this.id,
    puzzleId: puzzleId ?? this.puzzleId,
    status: status ?? this.status,
    bestTimeMs: bestTimeMs.present ? bestTimeMs.value : this.bestTimeMs,
    stars: stars ?? this.stars,
    progressPct: progressPct ?? this.progressPct,
    isFavorite: isFavorite ?? this.isFavorite,
    boardState: boardState.present ? boardState.value : this.boardState,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  UserPuzzle copyWithCompanion(UserPuzzlesCompanion data) {
    return UserPuzzle(
      id: data.id.present ? data.id.value : this.id,
      puzzleId: data.puzzleId.present ? data.puzzleId.value : this.puzzleId,
      status: data.status.present ? data.status.value : this.status,
      bestTimeMs: data.bestTimeMs.present
          ? data.bestTimeMs.value
          : this.bestTimeMs,
      stars: data.stars.present ? data.stars.value : this.stars,
      progressPct: data.progressPct.present
          ? data.progressPct.value
          : this.progressPct,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      boardState: data.boardState.present
          ? data.boardState.value
          : this.boardState,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPuzzle(')
          ..write('id: $id, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('status: $status, ')
          ..write('bestTimeMs: $bestTimeMs, ')
          ..write('stars: $stars, ')
          ..write('progressPct: $progressPct, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('boardState: $boardState, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    puzzleId,
    status,
    bestTimeMs,
    stars,
    progressPct,
    isFavorite,
    boardState,
    updatedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPuzzle &&
          other.id == this.id &&
          other.puzzleId == this.puzzleId &&
          other.status == this.status &&
          other.bestTimeMs == this.bestTimeMs &&
          other.stars == this.stars &&
          other.progressPct == this.progressPct &&
          other.isFavorite == this.isFavorite &&
          other.boardState == this.boardState &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class UserPuzzlesCompanion extends UpdateCompanion<UserPuzzle> {
  final Value<String> id;
  final Value<String> puzzleId;
  final Value<PuzzleStatus> status;
  final Value<int?> bestTimeMs;
  final Value<int> stars;
  final Value<double> progressPct;
  final Value<bool> isFavorite;
  final Value<String?> boardState;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const UserPuzzlesCompanion({
    this.id = const Value.absent(),
    this.puzzleId = const Value.absent(),
    this.status = const Value.absent(),
    this.bestTimeMs = const Value.absent(),
    this.stars = const Value.absent(),
    this.progressPct = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.boardState = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPuzzlesCompanion.insert({
    required String id,
    required String puzzleId,
    required PuzzleStatus status,
    this.bestTimeMs = const Value.absent(),
    this.stars = const Value.absent(),
    this.progressPct = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.boardState = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       puzzleId = Value(puzzleId),
       status = Value(status);
  static Insertable<UserPuzzle> custom({
    Expression<String>? id,
    Expression<String>? puzzleId,
    Expression<int>? status,
    Expression<int>? bestTimeMs,
    Expression<int>? stars,
    Expression<double>? progressPct,
    Expression<bool>? isFavorite,
    Expression<String>? boardState,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (puzzleId != null) 'puzzle_id': puzzleId,
      if (status != null) 'status': status,
      if (bestTimeMs != null) 'best_time_ms': bestTimeMs,
      if (stars != null) 'stars': stars,
      if (progressPct != null) 'progress_pct': progressPct,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (boardState != null) 'board_state': boardState,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPuzzlesCompanion copyWith({
    Value<String>? id,
    Value<String>? puzzleId,
    Value<PuzzleStatus>? status,
    Value<int?>? bestTimeMs,
    Value<int>? stars,
    Value<double>? progressPct,
    Value<bool>? isFavorite,
    Value<String?>? boardState,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return UserPuzzlesCompanion(
      id: id ?? this.id,
      puzzleId: puzzleId ?? this.puzzleId,
      status: status ?? this.status,
      bestTimeMs: bestTimeMs ?? this.bestTimeMs,
      stars: stars ?? this.stars,
      progressPct: progressPct ?? this.progressPct,
      isFavorite: isFavorite ?? this.isFavorite,
      boardState: boardState ?? this.boardState,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (puzzleId.present) {
      map['puzzle_id'] = Variable<String>(puzzleId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $UserPuzzlesTable.$converterstatus.toSql(status.value),
      );
    }
    if (bestTimeMs.present) {
      map['best_time_ms'] = Variable<int>(bestTimeMs.value);
    }
    if (stars.present) {
      map['stars'] = Variable<int>(stars.value);
    }
    if (progressPct.present) {
      map['progress_pct'] = Variable<double>(progressPct.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (boardState.present) {
      map['board_state'] = Variable<String>(boardState.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPuzzlesCompanion(')
          ..write('id: $id, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('status: $status, ')
          ..write('bestTimeMs: $bestTimeMs, ')
          ..write('stars: $stars, ')
          ..write('progressPct: $progressPct, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('boardState: $boardState, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, AppUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<String> rank = GeneratedColumn<String>(
    'rank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Novato'),
  );
  static const VerificationMeta _streakDaysMeta = const VerificationMeta(
    'streakDays',
  );
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
    'streak_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _coinsMeta = const VerificationMeta('coins');
  @override
  late final GeneratedColumn<int> coins = GeneratedColumn<int>(
    'coins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
    'joined_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _statsMeta = const VerificationMeta('stats');
  @override
  late final GeneratedColumn<String> stats = GeneratedColumn<String>(
    'stats',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    level,
    xp,
    rank,
    streakDays,
    coins,
    joinedAt,
    stats,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('rank')) {
      context.handle(
        _rankMeta,
        rank.isAcceptableOrUnknown(data['rank']!, _rankMeta),
      );
    }
    if (data.containsKey('streak_days')) {
      context.handle(
        _streakDaysMeta,
        streakDays.isAcceptableOrUnknown(data['streak_days']!, _streakDaysMeta),
      );
    }
    if (data.containsKey('coins')) {
      context.handle(
        _coinsMeta,
        coins.isAcceptableOrUnknown(data['coins']!, _coinsMeta),
      );
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    }
    if (data.containsKey('stats')) {
      context.handle(
        _statsMeta,
        stats.isAcceptableOrUnknown(data['stats']!, _statsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      rank: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rank'],
      )!,
      streakDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_days'],
      )!,
      coins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coins'],
      )!,
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_at'],
      )!,
      stats: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stats'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class AppUser extends DataClass implements Insertable<AppUser> {
  final String id;
  final String username;
  final int level;
  final int xp;
  final String rank;
  final int streakDays;
  final int coins;
  final DateTime joinedAt;

  /// Stats agregadas (JSON). Se llena en Fase 2.
  final String? stats;
  const AppUser({
    required this.id,
    required this.username,
    required this.level,
    required this.xp,
    required this.rank,
    required this.streakDays,
    required this.coins,
    required this.joinedAt,
    this.stats,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['level'] = Variable<int>(level);
    map['xp'] = Variable<int>(xp);
    map['rank'] = Variable<String>(rank);
    map['streak_days'] = Variable<int>(streakDays);
    map['coins'] = Variable<int>(coins);
    map['joined_at'] = Variable<DateTime>(joinedAt);
    if (!nullToAbsent || stats != null) {
      map['stats'] = Variable<String>(stats);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      level: Value(level),
      xp: Value(xp),
      rank: Value(rank),
      streakDays: Value(streakDays),
      coins: Value(coins),
      joinedAt: Value(joinedAt),
      stats: stats == null && nullToAbsent
          ? const Value.absent()
          : Value(stats),
    );
  }

  factory AppUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUser(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      level: serializer.fromJson<int>(json['level']),
      xp: serializer.fromJson<int>(json['xp']),
      rank: serializer.fromJson<String>(json['rank']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      coins: serializer.fromJson<int>(json['coins']),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
      stats: serializer.fromJson<String?>(json['stats']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'level': serializer.toJson<int>(level),
      'xp': serializer.toJson<int>(xp),
      'rank': serializer.toJson<String>(rank),
      'streakDays': serializer.toJson<int>(streakDays),
      'coins': serializer.toJson<int>(coins),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
      'stats': serializer.toJson<String?>(stats),
    };
  }

  AppUser copyWith({
    String? id,
    String? username,
    int? level,
    int? xp,
    String? rank,
    int? streakDays,
    int? coins,
    DateTime? joinedAt,
    Value<String?> stats = const Value.absent(),
  }) => AppUser(
    id: id ?? this.id,
    username: username ?? this.username,
    level: level ?? this.level,
    xp: xp ?? this.xp,
    rank: rank ?? this.rank,
    streakDays: streakDays ?? this.streakDays,
    coins: coins ?? this.coins,
    joinedAt: joinedAt ?? this.joinedAt,
    stats: stats.present ? stats.value : this.stats,
  );
  AppUser copyWithCompanion(UsersCompanion data) {
    return AppUser(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      level: data.level.present ? data.level.value : this.level,
      xp: data.xp.present ? data.xp.value : this.xp,
      rank: data.rank.present ? data.rank.value : this.rank,
      streakDays: data.streakDays.present
          ? data.streakDays.value
          : this.streakDays,
      coins: data.coins.present ? data.coins.value : this.coins,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      stats: data.stats.present ? data.stats.value : this.stats,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUser(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('rank: $rank, ')
          ..write('streakDays: $streakDays, ')
          ..write('coins: $coins, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('stats: $stats')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    level,
    xp,
    rank,
    streakDays,
    coins,
    joinedAt,
    stats,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          other.id == this.id &&
          other.username == this.username &&
          other.level == this.level &&
          other.xp == this.xp &&
          other.rank == this.rank &&
          other.streakDays == this.streakDays &&
          other.coins == this.coins &&
          other.joinedAt == this.joinedAt &&
          other.stats == this.stats);
}

class UsersCompanion extends UpdateCompanion<AppUser> {
  final Value<String> id;
  final Value<String> username;
  final Value<int> level;
  final Value<int> xp;
  final Value<String> rank;
  final Value<int> streakDays;
  final Value<int> coins;
  final Value<DateTime> joinedAt;
  final Value<String?> stats;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.rank = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.coins = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.stats = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String username,
    this.level = const Value.absent(),
    this.xp = const Value.absent(),
    this.rank = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.coins = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.stats = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       username = Value(username);
  static Insertable<AppUser> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<int>? level,
    Expression<int>? xp,
    Expression<String>? rank,
    Expression<int>? streakDays,
    Expression<int>? coins,
    Expression<DateTime>? joinedAt,
    Expression<String>? stats,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (level != null) 'level': level,
      if (xp != null) 'xp': xp,
      if (rank != null) 'rank': rank,
      if (streakDays != null) 'streak_days': streakDays,
      if (coins != null) 'coins': coins,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (stats != null) 'stats': stats,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? username,
    Value<int>? level,
    Value<int>? xp,
    Value<String>? rank,
    Value<int>? streakDays,
    Value<int>? coins,
    Value<DateTime>? joinedAt,
    Value<String?>? stats,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      rank: rank ?? this.rank,
      streakDays: streakDays ?? this.streakDays,
      coins: coins ?? this.coins,
      joinedAt: joinedAt ?? this.joinedAt,
      stats: stats ?? this.stats,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(rank.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (coins.present) {
      map['coins'] = Variable<int>(coins.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (stats.present) {
      map['stats'] = Variable<String>(stats.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('level: $level, ')
          ..write('xp: $xp, ')
          ..write('rank: $rank, ')
          ..write('streakDays: $streakDays, ')
          ..write('coins: $coins, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('stats: $stats, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlacesTable places = $PlacesTable(this);
  late final $PuzzlesTable puzzles = $PuzzlesTable(this);
  late final $UserPuzzlesTable userPuzzles = $UserPuzzlesTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    places,
    puzzles,
    userPuzzles,
    users,
  ];
}

typedef $$PlacesTableCreateCompanionBuilder =
    PlacesCompanion Function({
      required String id,
      required String name,
      required String location,
      required String state,
      required Category category,
      required String description,
      required List<Fact> facts,
      required String didYouKnow,
      required String imagePath,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PlacesTableUpdateCompanionBuilder =
    PlacesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> location,
      Value<String> state,
      Value<Category> category,
      Value<String> description,
      Value<List<Fact>> facts,
      Value<String> didYouKnow,
      Value<String> imagePath,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PlacesTableReferences
    extends BaseReferences<_$AppDatabase, $PlacesTable, Place> {
  $$PlacesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PuzzlesTable, List<Puzzle>> _puzzlesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.puzzles,
    aliasName: 'places__id__puzzles__place_id',
  );

  $$PuzzlesTableProcessedTableManager get puzzlesRefs {
    final manager = $$PuzzlesTableTableManager(
      $_db,
      $_db.puzzles,
    ).filter((f) => f.placeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_puzzlesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlacesTableFilterComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Category, Category, int> get category =>
      $composableBuilder(
        column: $table.category,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<Fact>, List<Fact>, String> get facts =>
      $composableBuilder(
        column: $table.facts,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get didYouKnow => $composableBuilder(
    column: $table.didYouKnow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> puzzlesRefs(
    Expression<bool> Function($$PuzzlesTableFilterComposer f) f,
  ) {
    final $$PuzzlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.puzzles,
      getReferencedColumn: (t) => t.placeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PuzzlesTableFilterComposer(
            $db: $db,
            $table: $db.puzzles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facts => $composableBuilder(
    column: $table.facts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get didYouKnow => $composableBuilder(
    column: $table.didYouKnow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Category, int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<Fact>, String> get facts =>
      $composableBuilder(column: $table.facts, builder: (column) => column);

  GeneratedColumn<String> get didYouKnow => $composableBuilder(
    column: $table.didYouKnow,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> puzzlesRefs<T extends Object>(
    Expression<T> Function($$PuzzlesTableAnnotationComposer a) f,
  ) {
    final $$PuzzlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.puzzles,
      getReferencedColumn: (t) => t.placeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PuzzlesTableAnnotationComposer(
            $db: $db,
            $table: $db.puzzles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlacesTable,
          Place,
          $$PlacesTableFilterComposer,
          $$PlacesTableOrderingComposer,
          $$PlacesTableAnnotationComposer,
          $$PlacesTableCreateCompanionBuilder,
          $$PlacesTableUpdateCompanionBuilder,
          (Place, $$PlacesTableReferences),
          Place,
          PrefetchHooks Function({bool puzzlesRefs})
        > {
  $$PlacesTableTableManager(_$AppDatabase db, $PlacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<Category> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<List<Fact>> facts = const Value.absent(),
                Value<String> didYouKnow = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlacesCompanion(
                id: id,
                name: name,
                location: location,
                state: state,
                category: category,
                description: description,
                facts: facts,
                didYouKnow: didYouKnow,
                imagePath: imagePath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String location,
                required String state,
                required Category category,
                required String description,
                required List<Fact> facts,
                required String didYouKnow,
                required String imagePath,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlacesCompanion.insert(
                id: id,
                name: name,
                location: location,
                state: state,
                category: category,
                description: description,
                facts: facts,
                didYouKnow: didYouKnow,
                imagePath: imagePath,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PlacesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({puzzlesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (puzzlesRefs) db.puzzles],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (puzzlesRefs)
                    await $_getPrefetchedData<Place, $PlacesTable, Puzzle>(
                      currentTable: table,
                      referencedTable: $$PlacesTableReferences
                          ._puzzlesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PlacesTableReferences(db, table, p0).puzzlesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.placeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlacesTable,
      Place,
      $$PlacesTableFilterComposer,
      $$PlacesTableOrderingComposer,
      $$PlacesTableAnnotationComposer,
      $$PlacesTableCreateCompanionBuilder,
      $$PlacesTableUpdateCompanionBuilder,
      (Place, $$PlacesTableReferences),
      Place,
      PrefetchHooks Function({bool puzzlesRefs})
    >;
typedef $$PuzzlesTableCreateCompanionBuilder =
    PuzzlesCompanion Function({
      required String id,
      required String placeId,
      required Difficulty difficulty,
      Value<int> rowid,
    });
typedef $$PuzzlesTableUpdateCompanionBuilder =
    PuzzlesCompanion Function({
      Value<String> id,
      Value<String> placeId,
      Value<Difficulty> difficulty,
      Value<int> rowid,
    });

final class $$PuzzlesTableReferences
    extends BaseReferences<_$AppDatabase, $PuzzlesTable, Puzzle> {
  $$PuzzlesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTable _placeIdTable(_$AppDatabase db) =>
      db.places.createAlias('puzzles__place_id__places__id');

  $$PlacesTableProcessedTableManager get placeId {
    final $_column = $_itemColumn<String>('place_id')!;

    final manager = $$PlacesTableTableManager(
      $_db,
      $_db.places,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$UserPuzzlesTable, List<UserPuzzle>>
  _userPuzzlesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userPuzzles,
    aliasName: 'puzzles__id__user_puzzles__puzzle_id',
  );

  $$UserPuzzlesTableProcessedTableManager get userPuzzlesRefs {
    final manager = $$UserPuzzlesTableTableManager(
      $_db,
      $_db.userPuzzles,
    ).filter((f) => f.puzzleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userPuzzlesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PuzzlesTableFilterComposer
    extends Composer<_$AppDatabase, $PuzzlesTable> {
  $$PuzzlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Difficulty, Difficulty, int> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$PlacesTableFilterComposer get placeId {
    final $$PlacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableFilterComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> userPuzzlesRefs(
    Expression<bool> Function($$UserPuzzlesTableFilterComposer f) f,
  ) {
    final $$UserPuzzlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPuzzles,
      getReferencedColumn: (t) => t.puzzleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPuzzlesTableFilterComposer(
            $db: $db,
            $table: $db.userPuzzles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PuzzlesTableOrderingComposer
    extends Composer<_$AppDatabase, $PuzzlesTable> {
  $$PuzzlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlacesTableOrderingComposer get placeId {
    final $$PlacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableOrderingComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PuzzlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PuzzlesTable> {
  $$PuzzlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Difficulty, int> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => column,
      );

  $$PlacesTableAnnotationComposer get placeId {
    final $$PlacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableAnnotationComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> userPuzzlesRefs<T extends Object>(
    Expression<T> Function($$UserPuzzlesTableAnnotationComposer a) f,
  ) {
    final $$UserPuzzlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPuzzles,
      getReferencedColumn: (t) => t.puzzleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPuzzlesTableAnnotationComposer(
            $db: $db,
            $table: $db.userPuzzles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PuzzlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PuzzlesTable,
          Puzzle,
          $$PuzzlesTableFilterComposer,
          $$PuzzlesTableOrderingComposer,
          $$PuzzlesTableAnnotationComposer,
          $$PuzzlesTableCreateCompanionBuilder,
          $$PuzzlesTableUpdateCompanionBuilder,
          (Puzzle, $$PuzzlesTableReferences),
          Puzzle,
          PrefetchHooks Function({bool placeId, bool userPuzzlesRefs})
        > {
  $$PuzzlesTableTableManager(_$AppDatabase db, $PuzzlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PuzzlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PuzzlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PuzzlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> placeId = const Value.absent(),
                Value<Difficulty> difficulty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PuzzlesCompanion(
                id: id,
                placeId: placeId,
                difficulty: difficulty,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String placeId,
                required Difficulty difficulty,
                Value<int> rowid = const Value.absent(),
              }) => PuzzlesCompanion.insert(
                id: id,
                placeId: placeId,
                difficulty: difficulty,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PuzzlesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({placeId = false, userPuzzlesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (userPuzzlesRefs) db.userPuzzles],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (placeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.placeId,
                                referencedTable: $$PuzzlesTableReferences
                                    ._placeIdTable(db),
                                referencedColumn: $$PuzzlesTableReferences
                                    ._placeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userPuzzlesRefs)
                    await $_getPrefetchedData<
                      Puzzle,
                      $PuzzlesTable,
                      UserPuzzle
                    >(
                      currentTable: table,
                      referencedTable: $$PuzzlesTableReferences
                          ._userPuzzlesRefsTable(db),
                      managerFromTypedResult: (p0) => $$PuzzlesTableReferences(
                        db,
                        table,
                        p0,
                      ).userPuzzlesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.puzzleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PuzzlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PuzzlesTable,
      Puzzle,
      $$PuzzlesTableFilterComposer,
      $$PuzzlesTableOrderingComposer,
      $$PuzzlesTableAnnotationComposer,
      $$PuzzlesTableCreateCompanionBuilder,
      $$PuzzlesTableUpdateCompanionBuilder,
      (Puzzle, $$PuzzlesTableReferences),
      Puzzle,
      PrefetchHooks Function({bool placeId, bool userPuzzlesRefs})
    >;
typedef $$UserPuzzlesTableCreateCompanionBuilder =
    UserPuzzlesCompanion Function({
      required String id,
      required String puzzleId,
      required PuzzleStatus status,
      Value<int?> bestTimeMs,
      Value<int> stars,
      Value<double> progressPct,
      Value<bool> isFavorite,
      Value<String?> boardState,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$UserPuzzlesTableUpdateCompanionBuilder =
    UserPuzzlesCompanion Function({
      Value<String> id,
      Value<String> puzzleId,
      Value<PuzzleStatus> status,
      Value<int?> bestTimeMs,
      Value<int> stars,
      Value<double> progressPct,
      Value<bool> isFavorite,
      Value<String?> boardState,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

final class $$UserPuzzlesTableReferences
    extends BaseReferences<_$AppDatabase, $UserPuzzlesTable, UserPuzzle> {
  $$UserPuzzlesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PuzzlesTable _puzzleIdTable(_$AppDatabase db) =>
      db.puzzles.createAlias('user_puzzles__puzzle_id__puzzles__id');

  $$PuzzlesTableProcessedTableManager get puzzleId {
    final $_column = $_itemColumn<String>('puzzle_id')!;

    final manager = $$PuzzlesTableTableManager(
      $_db,
      $_db.puzzles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_puzzleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserPuzzlesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPuzzlesTable> {
  $$UserPuzzlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PuzzleStatus, PuzzleStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get bestTimeMs => $composableBuilder(
    column: $table.bestTimeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stars => $composableBuilder(
    column: $table.stars,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progressPct => $composableBuilder(
    column: $table.progressPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boardState => $composableBuilder(
    column: $table.boardState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PuzzlesTableFilterComposer get puzzleId {
    final $$PuzzlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.puzzleId,
      referencedTable: $db.puzzles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PuzzlesTableFilterComposer(
            $db: $db,
            $table: $db.puzzles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPuzzlesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPuzzlesTable> {
  $$UserPuzzlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestTimeMs => $composableBuilder(
    column: $table.bestTimeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stars => $composableBuilder(
    column: $table.stars,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progressPct => $composableBuilder(
    column: $table.progressPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boardState => $composableBuilder(
    column: $table.boardState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PuzzlesTableOrderingComposer get puzzleId {
    final $$PuzzlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.puzzleId,
      referencedTable: $db.puzzles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PuzzlesTableOrderingComposer(
            $db: $db,
            $table: $db.puzzles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPuzzlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPuzzlesTable> {
  $$UserPuzzlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PuzzleStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get bestTimeMs => $composableBuilder(
    column: $table.bestTimeMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stars =>
      $composableBuilder(column: $table.stars, builder: (column) => column);

  GeneratedColumn<double> get progressPct => $composableBuilder(
    column: $table.progressPct,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get boardState => $composableBuilder(
    column: $table.boardState,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  $$PuzzlesTableAnnotationComposer get puzzleId {
    final $$PuzzlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.puzzleId,
      referencedTable: $db.puzzles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PuzzlesTableAnnotationComposer(
            $db: $db,
            $table: $db.puzzles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPuzzlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPuzzlesTable,
          UserPuzzle,
          $$UserPuzzlesTableFilterComposer,
          $$UserPuzzlesTableOrderingComposer,
          $$UserPuzzlesTableAnnotationComposer,
          $$UserPuzzlesTableCreateCompanionBuilder,
          $$UserPuzzlesTableUpdateCompanionBuilder,
          (UserPuzzle, $$UserPuzzlesTableReferences),
          UserPuzzle,
          PrefetchHooks Function({bool puzzleId})
        > {
  $$UserPuzzlesTableTableManager(_$AppDatabase db, $UserPuzzlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPuzzlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPuzzlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPuzzlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> puzzleId = const Value.absent(),
                Value<PuzzleStatus> status = const Value.absent(),
                Value<int?> bestTimeMs = const Value.absent(),
                Value<int> stars = const Value.absent(),
                Value<double> progressPct = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> boardState = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPuzzlesCompanion(
                id: id,
                puzzleId: puzzleId,
                status: status,
                bestTimeMs: bestTimeMs,
                stars: stars,
                progressPct: progressPct,
                isFavorite: isFavorite,
                boardState: boardState,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String puzzleId,
                required PuzzleStatus status,
                Value<int?> bestTimeMs = const Value.absent(),
                Value<int> stars = const Value.absent(),
                Value<double> progressPct = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> boardState = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPuzzlesCompanion.insert(
                id: id,
                puzzleId: puzzleId,
                status: status,
                bestTimeMs: bestTimeMs,
                stars: stars,
                progressPct: progressPct,
                isFavorite: isFavorite,
                boardState: boardState,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserPuzzlesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({puzzleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (puzzleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.puzzleId,
                                referencedTable: $$UserPuzzlesTableReferences
                                    ._puzzleIdTable(db),
                                referencedColumn: $$UserPuzzlesTableReferences
                                    ._puzzleIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserPuzzlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPuzzlesTable,
      UserPuzzle,
      $$UserPuzzlesTableFilterComposer,
      $$UserPuzzlesTableOrderingComposer,
      $$UserPuzzlesTableAnnotationComposer,
      $$UserPuzzlesTableCreateCompanionBuilder,
      $$UserPuzzlesTableUpdateCompanionBuilder,
      (UserPuzzle, $$UserPuzzlesTableReferences),
      UserPuzzle,
      PrefetchHooks Function({bool puzzleId})
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      required String username,
      Value<int> level,
      Value<int> xp,
      Value<String> rank,
      Value<int> streakDays,
      Value<int> coins,
      Value<DateTime> joinedAt,
      Value<String?> stats,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> username,
      Value<int> level,
      Value<int> xp,
      Value<String> rank,
      Value<int> streakDays,
      Value<int> coins,
      Value<DateTime> joinedAt,
      Value<String?> stats,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stats => $composableBuilder(
    column: $table.stats,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stats => $composableBuilder(
    column: $table.stats,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<String> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get coins =>
      $composableBuilder(column: $table.coins, builder: (column) => column);

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<String> get stats =>
      $composableBuilder(column: $table.stats, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          AppUser,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (AppUser, BaseReferences<_$AppDatabase, $UsersTable, AppUser>),
          AppUser,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<String> rank = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<DateTime> joinedAt = const Value.absent(),
                Value<String?> stats = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                level: level,
                xp: xp,
                rank: rank,
                streakDays: streakDays,
                coins: coins,
                joinedAt: joinedAt,
                stats: stats,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String username,
                Value<int> level = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<String> rank = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<DateTime> joinedAt = const Value.absent(),
                Value<String?> stats = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                level: level,
                xp: xp,
                rank: rank,
                streakDays: streakDays,
                coins: coins,
                joinedAt: joinedAt,
                stats: stats,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      AppUser,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (AppUser, BaseReferences<_$AppDatabase, $UsersTable, AppUser>),
      AppUser,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlacesTableTableManager get places =>
      $$PlacesTableTableManager(_db, _db.places);
  $$PuzzlesTableTableManager get puzzles =>
      $$PuzzlesTableTableManager(_db, _db.puzzles);
  $$UserPuzzlesTableTableManager get userPuzzles =>
      $$UserPuzzlesTableTableManager(_db, _db.userPuzzles);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
