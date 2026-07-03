# language: es
Característica: Motor de jigsaw

  Escenario: Genera N piezas con lengüetas complementarias
    Dado que genero un tablero de 3x3 piezas para un área de tablero dada
    Entonces obtengo exactamente 9 piezas
    Y las piezas de la esquina superior izquierda tienen borde recto (flat) arriba y a la izquierda
    Y el borde derecho de cada pieza es complementario (tabOut/tabIn) del borde izquierdo de su vecina de la derecha
    Y el borde inferior de cada pieza es complementario del borde superior de su vecina de abajo

  Esquema del escenario: gridForCount produce cols×rows == pieceCount para cada dificultad
    Dado que la dificultad tiene <pieceCount> piezas
    Cuando calculo la grilla con gridForCount
    Entonces cols multiplicado por rows es igual a <pieceCount>

    Ejemplos:
      | pieceCount |
      | 50         |
      | 110        |
      | 200        |
      | 300        |
      | 440        |

  Escenario: Arrastrar y soltar cerca de la posición correcta hace snap
    Dado que una pieza está a menos del umbral de snap de distancia de su posición "home", con rotación correcta
    Cuando suelto la pieza
    Entonces la pieza queda colocada (placed = true) exactamente en su posición home

  Escenario: Soltar lejos de la posición correcta no hace snap
    Dado que una pieza está a más del umbral de snap de distancia de su posición home
    Cuando suelto la pieza
    Entonces la pieza no queda colocada y conserva su posición actual

  Escenario: Soltar con rotación incorrecta no hace snap (si "Rotar Piezas" está ON)
    Dado que el ajuste "Rotar Piezas" está activo y una pieza tiene una rotación distinta de 0
    Y esa pieza está cerca de su posición home
    Cuando suelto la pieza
    Entonces la pieza no queda colocada porque su orientación no es la correcta

  Escenario: Dos piezas vecinas en relación correcta se unen en un grupo
    Dado que dos piezas vecinas (adyacentes en la grilla) están orientadas correctamente
    Y su posición relativa entre sí coincide con la relación de sus posiciones home dentro del umbral de snap
    Cuando suelto una de las dos piezas
    Entonces ambas piezas quedan en el mismo grupo (mismo id de unión)

  Escenario: Un grupo de piezas unidas se mueve como una sola unidad
    Dado que dos piezas ya están unidas en un mismo grupo
    Cuando arrastro una de las piezas del grupo un delta (dx, dy)
    Entonces todas las piezas no colocadas del grupo se desplazan por el mismo delta

  Escenario: Completar el tablero marca la partida como terminada
    Dado que todas las piezas de un tablero están en su posición home
    Cuando suelto cada una de ellas
    Entonces el tablero queda completo (isComplete = true)

  Escenario: Completar guarda el mejor tiempo, las estrellas y navega a Reveal
    Dado que estoy jugando un puzzle y coloco la última pieza en su lugar
    Cuando el tablero queda completo
    Entonces se guarda en `user_puzzles` el estado "completed", el `best_time_ms` transcurrido y las estrellas calculadas
    Y la app navega a la pantalla Reveal del mismo puzzle

  Escenario: El mejor tiempo solo se actualiza si el nuevo tiempo es menor
    Dado que existe un `best_time_ms` previo guardado para un puzzle
    Cuando completo el puzzle de nuevo con un tiempo mayor al récord previo
    Entonces el `best_time_ms` guardado sigue siendo el más bajo de los dos

  Esquema del escenario: Las estrellas se calculan según el tiempo por pieza
    Dado que completo un puzzle de 50 piezas en <tiempo_ms> milisegundos
    Cuando se calculan las estrellas
    Entonces se otorgan <estrellas> estrellas

    Ejemplos:
      | tiempo_ms | estrellas |
      | 49000     | 3         |
      | 75000     | 2         |
      | 150000    | 1         |

  Escenario: Salir y volver reanuda la partida exactamente donde estaba
    Dado que tengo una partida en progreso con algunas piezas colocadas y otras dispersas en posiciones arbitrarias
    Cuando salgo de la pantalla de juego y vuelvo a entrar al mismo puzzle (misma área de tablero)
    Entonces cada pieza aparece en la misma posición, rotación y estado "colocada" que tenía al salir

  Escenario: El progreso parcial persiste aunque no se complete el puzzle
    Dado que coloco solo una parte de las piezas de un puzzle
    Cuando salgo sin completar la partida
    Entonces `user_puzzles` guarda status "in_progress", el `board_state` y el `progress_pct` correspondiente a las piezas colocadas

  # Edge cases
  Escenario: Reanudar en un área de tablero de distinto tamaño no rompe el estado
    Dado que guardé una partida en progreso con el tablero medido en un tamaño de pantalla A
    Cuando reanudo la partida en un tamaño de pantalla B distinto (p. ej. tras rotar el dispositivo)
    Entonces las piezas ya colocadas siguen alineadas a la nueva grilla en sus celdas correctas

  Escenario: Reingresar a un puzzle ya completado no deja el tablero congelado
    Dado que un puzzle ya tiene status "completed" y su `board_state` con todas las piezas colocadas
    Cuando vuelvo a abrir ese puzzle desde "Jugar" en Difficulty Select
    Entonces la app navega directo a Reveal o permite reiniciar la partida, pero no muestra un tablero sin ninguna interacción posible

  Escenario: El motor funciona completamente offline
    Dado que el dispositivo está sin conexión a internet
    Cuando genero el tablero, arrastro piezas, hago snap y completo el puzzle
    Entonces todas las operaciones (generación, snap, persistencia, mejor tiempo) funcionan contra la base de datos local sin depender de red

  Escenario: 440 piezas se generan y manipulan sin errores de lógica en dispositivo de gama media/baja
    Dado que genero un tablero de dificultad "Experto" (440 piezas, grilla 20x22)
    Cuando arrastro, suelto y agrupo piezas repetidamente
    Entonces el motor no lanza errores y el framerate se mantiene fluido
    # Nota: el framerate en dispositivo real de gama baja NO está validado en este PR (riesgo abierto declarado en TECH §10).
