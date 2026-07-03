# language: es
Característica: Pantalla Place Reveal (payoff post-partida)

  Escenario: Muestra nombre, ubicación y resumen de la partida al completar el puzzle
    Dado que el usuario completó el puzzle "salto-angel-facil" con mejor tiempo de 102000 ms y 3 estrellas
    Cuando navega a "/reveal/salto-angel-facil"
    Entonces ve el encabezado "ROMPECABEZAS COMPLETADO"
    Y ve el nombre del lugar "Salto Ángel"
    Y ve la ubicación como "{parque} · {estado}"
    Y ve el tiempo "01:42"
    Y ve la cantidad de piezas de la dificultad "Fácil" ("110")
    Y ve la etiqueta de dificultad "Fácil"

  Escenario: Renderiza descripción, datos clave y curiosidad del lugar
    Dado que el usuario está en la pantalla de reveal de un puzzle completado
    Cuando la pantalla termina de cargar los datos del lugar
    Entonces ve la sección "Sobre este lugar" con la descripción de `places.description`
    Y ve la sección "Datos clave" con una tarjeta por cada entrada de `places.facts` (métrica + valor)
    Y ve la sección "¿Sabías que?" con el contenido de `places.did_you_know`

  Escenario: Guardar en Colección persiste el favorito y da feedback al usuario
    Dado que el usuario está en la pantalla de reveal de un puzzle completado
    Cuando toca el botón "Guardar en Colección"
    Entonces se marca `is_favorite = true` para ese puzzle en `user_puzzles`
    Y ve el mensaje "Guardado en tu colección"
    Y el ícono del botón cambia a marcador relleno (bookmark)
    Y el botón "Guardar en Colección" queda deshabilitado para evitar guardados duplicados

  Escenario: Siguiente Rompecabezas lleva a otra partida
    Dado que el usuario está en la pantalla de reveal del lugar actual
    Cuando toca el botón "Siguiente Rompecabezas"
    Entonces navega a la selección de dificultad ("/difficulty/:placeId") de otro lugar distinto al actual

  Escenario: Compartir muestra un placeholder (share real queda para Fase 4)
    Dado que el usuario está en la pantalla de reveal de un puzzle completado
    Cuando toca el botón "Compartir"
    Entonces ve el mensaje "Compartir — próximamente"
    Y no se invoca ningún mecanismo de share nativo ni de red

  Escenario: Sin mejor tiempo registrado se muestra un guion en vez de un tiempo inválido
    Dado que el usuario navega directo a "/reveal/:puzzleId" sin un `user_puzzles.best_time_ms` guardado
    Cuando la pantalla carga los datos del reveal
    Entonces el resumen de tiempo muestra "—" en lugar de un valor numérico

  Escenario: Sin estrellas registradas no se muestra la fila de estrellas
    Dado que el `user_puzzles.stars` del puzzle es 0
    Cuando la pantalla de reveal se renderiza
    Entonces no se muestra la fila de íconos de estrellas

  Escenario: Lugar inexistente muestra un estado de error en vez de romper la pantalla
    Dado que el `puzzleId` de la ruta referencia un lugar que no existe en la base local
    Cuando la pantalla de reveal intenta cargar los datos
    Entonces se muestra un mensaje de error localizado en vez de una pantalla en blanco o un crash

  Escenario: Todos los textos visibles están traducidos vía i18n
    Dado que la pantalla de reveal está renderizada en el locale "es-VE"
    Cuando se inspeccionan los textos visibles de la pantalla (encabezado, secciones, botones, mensajes)
    Entonces ninguno proviene de un string hardcodeado sino de `AppLocalizations`
