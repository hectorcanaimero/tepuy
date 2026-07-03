# language: es
Característica: HUD y herramientas de la partida (spec 06)
  Como jugador de Tepuy
  Quiero ver información de la partida y contar con herramientas de ayuda
  Para poder seguir mi progreso y resolver el rompecabezas más fácilmente

  Antecedentes:
    Dado que elegí un lugar y una dificultad
    Y entré a la pantalla de Puzzle Play

  Escenario: El cronómetro arranca al entrar a la partida
    Cuando la pantalla de Puzzle Play termina de cargar el tablero
    Entonces el cronómetro muestra un tiempo transcurrido en formato "mm:ss"
    Y el tiempo avanza mientras la partida sigue en curso

  Escenario: El cronómetro se pausa al salir de la partida
    Dado que el cronómetro lleva un tiempo transcurrido mayor a cero
    Cuando la app pasa a segundo plano o el jugador vuelve a la pantalla anterior
    Entonces el cronómetro deja de avanzar
    Y al reingresar a la misma partida el cronómetro continúa desde el tiempo pausado

  Escenario: El contador de piezas colocadas se actualiza en tiempo real
    Dado que el tablero tiene un número total de piezas conocido
    Cuando el jugador coloca correctamente una pieza en su lugar
    Entonces el contador de "colocadas / total" incrementa en 1 inmediatamente
    Y el valor mostrado coincide con la cantidad real de piezas marcadas como colocadas en el tablero

  Escenario: La bandeja de piezas restantes muestra solo lo no colocado
    Dado que el tablero tiene piezas colocadas y piezas sin colocar
    Cuando se observa el HUD
    Entonces el contador de "restantes" muestra exactamente la cantidad de piezas no colocadas
    Y ese número disminuye cada vez que se coloca una pieza nueva

  Escenario: Usar la pista disponible resalta una pieza sin colocar
    Dado que el jugador tiene al menos 1 pista disponible en la partida
    Cuando el jugador presiona el botón de pista
    Entonces se resalta visualmente la posición correcta de una pieza aún no colocada
    Y el contador de pistas disponibles disminuye en 1

  Escenario: La pista se deshabilita al agotar el límite por partida
    Dado que el jugador ya usó la única pista gratis de la partida
    Cuando observa el botón de pista
    Entonces el botón de pista aparece deshabilitado
    Y presionarlo no tiene ningún efecto

  Escenario: La vista previa muestra la imagen completa mientras se mantiene
    Dado que la partida está en curso
    Cuando el jugador activa la vista previa
    Entonces se muestra un overlay translúcido con la imagen completa del lugar sobre el tablero
    Cuando el jugador desactiva la vista previa
    Entonces el overlay desaparece y el tablero vuelve a ser interactivo

  Escenario: El zoom in acerca el tablero
    Dado que el tablero se muestra a su escala inicial
    Cuando el jugador presiona el botón de acercar (zoom in)
    Entonces el tablero se muestra a una escala mayor que la anterior

  Escenario: El zoom out aleja el tablero
    Dado que el tablero se muestra a su escala inicial
    Cuando el jugador presiona el botón de alejar (zoom out)
    Entonces el tablero se muestra a una escala menor que la anterior

  Escenario: Deshacer revierte la última colocación
    Dado que el jugador acaba de colocar una pieza correctamente
    Cuando presiona el botón de deshacer
    Entonces la pieza vuelve a su estado anterior (no colocada)
    Y el contador de "colocadas" disminuye en 1

  Escenario: Deshacer está deshabilitado sin colocaciones previas
    Dado que el jugador no colocó ninguna pieza todavía en la partida
    Cuando observa el botón de deshacer
    Entonces el botón de deshacer aparece deshabilitado

  # Edge case: reingreso a partida ya completada
  Escenario: Reingresar a una partida completada la reinicia
    Dado que una partida guardada ya está completa al 100%
    Cuando el jugador vuelve a entrar a esa partida
    Entonces el tablero se reinicia con las piezas dispersas de nuevo
    Y el contador de "colocadas" arranca en 0

  # Edge case: header muestra info básica sin depender del progreso
  Escenario: El header muestra el nombre del lugar y permite volver
    Dado que la partida está en curso
    Cuando el jugador observa la parte superior de la pantalla
    Entonces ve el nombre del lugar
    Y ve un botón para volver a la pantalla anterior
