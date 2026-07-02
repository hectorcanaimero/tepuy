# language: es
Característica: Pantalla Difficulty Select

  Escenario: Muestra las 5 dificultades con su número de piezas correcto
    Dado que estoy en la pantalla Difficulty Select de un lugar del seed
    Entonces veo las 5 dificultades "Novato", "Fácil", "Medio", "Difícil" y "Experto"
    Y cada una muestra su número de piezas: 50, 110, 200, 300 y 440 respectivamente
    Y para ver las últimas dificultades de la lista hago scroll si no entran en la pantalla

  Escenario: Muestra "Sin récord" en una dificultad que el usuario nunca jugó
    Dado que estoy en la pantalla Difficulty Select de un lugar
    Y el usuario nunca completó una partida en la dificultad "Experto" de ese lugar
    Cuando abro la pantalla
    Entonces la dificultad "Experto" muestra el texto "Sin récord"

  Escenario: Muestra el mejor tiempo si el usuario ya jugó esa dificultad
    Dado que en `user_puzzles` existe un registro con mejor tiempo para la dificultad "Medio" de ese lugar
    Cuando abro la pantalla Difficulty Select de ese lugar
    Entonces la dificultad "Medio" muestra el mejor tiempo formateado como "mm:ss" (o "h:mm:ss" si supera la hora)
    Y ninguna otra dificultad sin registro muestra un tiempo, sino "Sin récord"

  Escenario: "Jugar" abre Puzzle Play con la dificultad seleccionada
    Dado que estoy en la pantalla Difficulty Select del lugar "placeId"
    Cuando selecciono la dificultad "Difícil"
    Y toco el botón "Jugar"
    Entonces navego a la ruta "/play/placeId-dificil"

  Escenario: Cambiar la selección antes de jugar actualiza el destino del CTA
    Dado que estoy en la pantalla Difficulty Select y la dificultad "Medio" está seleccionada por defecto
    Cuando toco la dificultad "Novato"
    Entonces la dificultad "Novato" queda marcada como seleccionada (borde/acento del tema)
    Y la dificultad "Medio" deja de estar marcada
    Cuando toco el botón "Jugar"
    Entonces navego a la ruta "/play/placeId-novato"

  Escenario: Todas las dificultades son seleccionables, sin candados en el MVP
    Dado que estoy en la pantalla Difficulty Select
    Entonces ninguna de las 5 dificultades muestra un ícono de candado
    Y puedo tocar y seleccionar cualquiera de las 5, incluida "Experto", sin restricción

  Escenario: El header muestra el lugar elegido
    Dado que navego a Difficulty Select para el lugar "Roraima" desde Home o Colección
    Entonces veo la imagen del lugar, su nombre "Roraima" y su ubicación

  Escenario: Todo el texto visible está localizado (es-VE)
    Dado que el locale de la app es es-VE
    Cuando abro la pantalla Difficulty Select
    Entonces los textos "Seleccioná la dificultad", "Jugar", "Sin récord" y "Mejor {tiempo}" se resuelven vía AppLocalizations
    Y ningún texto visible proviene de un literal hardcodeado en el widget

  # Edge cases
  Escenario: Difficulty Select no depende de conectividad (offline-first)
    Dado que el dispositivo está sin conexión a internet
    Cuando abro la pantalla Difficulty Select de un lugar del seed
    Entonces el lugar, las 5 dificultades y los mejores tiempos se cargan igual desde la base de datos local

  Escenario: Lugar inexistente no rompe la pantalla
    Dado que navego a "/difficulty/:placeId" con un placeId que no existe en la base local
    Cuando la pantalla intenta cargar el lugar
    Entonces se muestra un mensaje de error localizado en vez de romper la app
