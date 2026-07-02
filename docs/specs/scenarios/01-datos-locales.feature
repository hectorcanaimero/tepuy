# language: es
Característica: Datos locales (Drift + seed)
  Como jugador de Tepuy
  Quiero que la app tenga una base de datos local con lugares de Venezuela desde la instalación
  Para poder jugar offline sin depender de la nube (offline-first).

  Antecedentes:
    Dado que la app usa Drift como única fuente de verdad local
    Y que la base de datos se llama "tepuy"

  # --- Criterio de aceptación 1 ---
  Escenario: La DB se crea en el primer arranque y persiste entre sesiones
    Dado que es el primer arranque y la base de datos no existe
    Cuando la app inicializa la base de datos
    Entonces se ejecuta "onCreate" y se crean todas las tablas
    Y el seed se inserta una sola vez
    Cuando la app se cierra y se vuelve a abrir
    Entonces la base de datos ya existe y no se vuelve a sembrar
    Y los datos de la sesión anterior siguen presentes

  # --- Criterio de aceptación 2 ---
  Escenario: El seed inserta los lugares y consultarlos devuelve datos completos
    Dado que la base de datos se creó y ejecutó el seed
    Cuando consulto todos los lugares
    Entonces obtengo 8 lugares reales de Venezuela
    Y el lugar "salto-angel" tiene nombre, ubicación, estado y descripción no vacíos
    Y su lista de "facts" se deserializa desde JSON y no está vacía
    Y su categoría es "naturaleza"
    Y tiene una ruta de imagen "assets/places/salto-angel.jpg"

  Escenario: Cada lugar genera un puzzle por cada dificultad
    Dado que la base de datos se creó y ejecutó el seed
    Cuando consulto todos los puzzles
    Entonces la cantidad de puzzles es igual a la cantidad de lugares por 5 dificultades
    Y para el lugar "roraima" existe un puzzle por cada dificultad (novato, facil, medio, dificil, experto)

  # --- Criterio de aceptación 3 ---
  Escenario: La dificultad "medio" corresponde a 200 piezas
    Dado el enum Difficulty
    Cuando leo "Difficulty.medio.pieceCount"
    Entonces el valor es 200

  Esquema del escenario: Cada dificultad define su número de piezas
    Dado el enum Difficulty
    Cuando leo el "pieceCount" de "<dificultad>"
    Entonces el valor es <piezas>

    Ejemplos:
      | dificultad | piezas |
      | novato     | 50     |
      | facil      | 110    |
      | medio      | 200    |
      | dificil    | 300    |
      | experto    | 440    |

  # --- Criterio de aceptación 4 ---
  Escenario: Los repositorios entregan datos tipados consumibles desde providers
    Dado un ProviderContainer con la base de datos local
    Cuando leo "placeRepositoryProvider" y pido todos los lugares
    Entonces obtengo una lista tipada de "Place" no vacía
    Y al filtrar por la categoría "montanas" todos los resultados son de esa categoría

  # --- Edge cases / reglas del proyecto ---
  Escenario: Offline-first — el repositorio de usuario escribe y lee siempre en local
    Dado un puzzle sembrado
    Cuando guardo un "UserPuzzle" con progreso mediante el repositorio
    Entonces el registro se persiste en la base de datos local
    Y su campo "synced_at" queda en null (pendiente de subir en Fase 3)
    Cuando consulto ese puzzle por su id
    Entonces obtengo el progreso guardado sin acceder a la red

  Escenario: El estado del tablero se define pero no se usa en este spec
    Dado el esquema de la tabla "user_puzzles"
    Entonces existe la columna nullable "board_state" para reanudar partidas
    Y su uso queda diferido al spec 05
