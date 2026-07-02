import '../domain/enums.dart';
import 'app_database.dart';
import 'tables.dart';

/// Lugar del seed (antes de expandirse a filas de DB).
class _SeedPlace {
  const _SeedPlace({
    required this.id,
    required this.name,
    required this.location,
    required this.state,
    required this.category,
    required this.description,
    required this.facts,
    required this.didYouKnow,
  });

  final String id;
  final String name;
  final String location;
  final String state;
  final Category category;
  final String description;
  final List<Fact> facts;
  final String didYouKnow;

  String get imagePath => 'assets/places/$id.jpg';
}

/// Catálogo inicial empaquetado con la app (jugable offline desde la instalación).
const _seedPlaces = <_SeedPlace>[
  _SeedPlace(
    id: 'salto-angel',
    name: 'Salto Ángel',
    location: 'Parque Nacional Canaima',
    state: 'Bolívar',
    category: Category.naturaleza,
    description:
        'La cascada más alta del mundo, con una caída ininterrumpida de 807 '
        'metros. Brota desde la cima del Auyán-tepui y cae como un velo que se '
        'evapora antes de tocar el suelo.',
    facts: [
      Fact('Altura total', '979 m'),
      Fact('Caída libre', '807 m'),
      Fact('Descubierto', '1937'),
      Fact('Tepuy', 'Auyán-tepui'),
    ],
    didYouKnow:
        'Debe su nombre al aviador Jimmie Angel, que la sobrevoló en 1933 '
        'buscando oro. Es 19 veces más alta que las cataratas del Niágara.',
  ),
  _SeedPlace(
    id: 'roraima',
    name: 'Monte Roraima',
    location: 'Gran Sabana',
    state: 'Bolívar',
    category: Category.montanas,
    description:
        'El tepuy más famoso de la Gran Sabana: una meseta de paredes '
        'verticales que se eleva sobre la selva, con un ecosistema único en su cima.',
    facts: [
      Fact('Altura', '2.810 m'),
      Fact('Antigüedad', '~2.000 M de años'),
      Fact('Fronteras', 'Venezuela, Brasil, Guyana'),
    ],
    didYouKnow:
        'Inspiró la novela «El mundo perdido» de Arthur Conan Doyle por su '
        'aislamiento y sus especies endémicas.',
  ),
  _SeedPlace(
    id: 'los-roques',
    name: 'Los Roques',
    location: 'Dependencias Federales',
    state: 'Caribe',
    category: Category.islas,
    description:
        'Un archipiélago de aguas turquesas y arena blanca formado por unos '
        '350 cayos e islotes, uno de los mayores parques marinos del Caribe.',
    facts: [
      Fact('Cayos', '~350'),
      Fact('Área', '221.120 ha'),
      Fact('Parque desde', '1972'),
    ],
    didYouKnow:
        'Su laguna interior (El Gran Roque) es un atolón coralino, formación '
        'rarísima en el Atlántico.',
  ),
  _SeedPlace(
    id: 'medanos-coro',
    name: 'Médanos de Coro',
    location: 'Parque Nacional Médanos de Coro',
    state: 'Falcón',
    category: Category.naturaleza,
    description:
        'Un desierto de dunas móviles junto al mar, donde el viento esculpe '
        'colinas de arena que cambian de forma constantemente.',
    facts: [
      Fact('Dunas de hasta', '40 m'),
      Fact('Parque desde', '1974'),
      Fact('Clima', 'Semiárido'),
    ],
    didYouKnow:
        'Las dunas se desplazan con los vientos alisios, así que el paisaje '
        'nunca es el mismo dos días seguidos.',
  ),
  _SeedPlace(
    id: 'pico-bolivar',
    name: 'Pico Bolívar',
    location: 'Sierra Nevada de Mérida',
    state: 'Mérida',
    category: Category.montanas,
    description:
        'La montaña más alta de Venezuela, coronada por un busto de Simón '
        'Bolívar y accesible por el teleférico más alto y largo del mundo.',
    facts: [
      Fact('Altura', '4.978 m'),
      Fact('Cordillera', 'Andes'),
      Fact('Teleférico', 'Mukumbarí'),
    ],
    didYouKnow:
        'Hasta hace poco conservaba glaciares; el último de Venezuela se '
        'declaró extinto en años recientes.',
  ),
  _SeedPlace(
    id: 'el-avila',
    name: 'El Ávila',
    location: 'Parque Nacional Waraira Repano',
    state: 'Caracas',
    category: Category.montanas,
    description:
        'La montaña que separa a Caracas del mar Caribe, pulmón verde de la '
        'ciudad y su telón de fondo inconfundible.',
    facts: [
      Fact('Pico Naiguatá', '2.765 m'),
      Fact('Parque desde', '1958'),
      Fact('Teleférico', 'Warairarepano'),
    ],
    didYouKnow:
        'Su nombre indígena, Waraira Repano, significa «la sierra grande» en '
        'lengua de los pueblos originarios del valle.',
  ),
  _SeedPlace(
    id: 'morrocoy',
    name: 'Parque Morrocoy',
    location: 'Parque Nacional Morrocoy',
    state: 'Falcón',
    category: Category.playas,
    description:
        'Un laberinto de cayos, manglares y playas de aguas calmas, ideal '
        'para nadar entre bancos de arena y arrecifes.',
    facts: [
      Fact('Cayos', 'Sombrero, Sal, Muerto…'),
      Fact('Parque desde', '1974'),
      Fact('Ecosistema', 'Manglar y coral'),
    ],
    didYouKnow:
        'Cayo Sombrero, con sus cocoteros sobre la arena, es una de las playas '
        'más fotografiadas del país.',
  ),
  _SeedPlace(
    id: 'choroni',
    name: 'Choroní',
    location: 'Parque Nacional Henri Pittier',
    state: 'Aragua',
    category: Category.playas,
    description:
        'Un pueblo colonial de casas coloridas entre la selva nublada y el '
        'mar, puerta a playas como Cepe y Chuao.',
    facts: [
      Fact('Parque', 'Henri Pittier'),
      Fact('Primer parque nacional', '1937'),
      Fact('Famoso por', 'Cacao de Chuao'),
    ],
    didYouKnow:
        'El cacao de la vecina Chuao es considerado uno de los mejores del '
        'mundo y tiene denominación de origen.',
  ),
];

/// Inserta el catálogo inicial: cada lugar + un puzzle por dificultad.
Future<void> seedDatabase(AppDatabase db) async {
  await db.batch((b) {
    for (final p in _seedPlaces) {
      b.insert(
        db.places,
        PlacesCompanion.insert(
          id: p.id,
          name: p.name,
          location: p.location,
          state: p.state,
          category: p.category,
          description: p.description,
          facts: p.facts,
          didYouKnow: p.didYouKnow,
          imagePath: p.imagePath,
        ),
      );
      for (final d in Difficulty.values) {
        b.insert(
          db.puzzles,
          PuzzlesCompanion.insert(
            id: '${p.id}-${d.name}',
            placeId: p.id,
            difficulty: d,
          ),
        );
      }
    }
  });
}
