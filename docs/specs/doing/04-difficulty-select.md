# Spec 04 — Pantalla Difficulty Select

**Estado:** backlog _(la carpeta manda)_
**Fase:** 1
**Depende de:** 01, 02

## Objetivo
Elegir la dificultad de un puzzle antes de jugar. Define cuántas piezas tendrá la partida.

## Alcance
**Entra:**
- Header con el lugar elegido (nombre + ubicación) e imagen.
- Lista de dificultades: **Novato 50 · Fácil 110 · Medio 200 · Difícil 300 · Experto 440** piezas.
- Por dificultad: nº piezas, mejor tiempo (de `user_puzzles` si existe), estado.
- CTA "Jugar" sobre la dificultad seleccionada → navega a Puzzle Play (spec 05/06) con `puzzleId` + `difficulty`.

**NO entra:**
- Bloqueo por progresión (ej. "Conseguí 2★ en Medio"). En offline-MVP **todas las
  dificultades están desbloqueadas**. El layout muestra candados → eso es Fase 2 (Levels Journey).
- XP por dificultad (Fase 2).

## Detalle técnico
- `features/journey/ui/difficulty_select_screen.dart`.
- Recibe `puzzleId` por ruta; carga el lugar y los mejores tiempos por dificultad.
- Selección = estado local; el CTA pasa la dificultad elegida a la ruta de Play.
- `Difficulty` enum del spec 01 provee `pieceCount`.

## Criterios de aceptación
- [ ] Muestra las 5 dificultades con su nº de piezas correcto.
- [ ] Muestra mejor tiempo si el usuario ya jugó esa dificultad.
- [ ] "Jugar" abre Puzzle Play con la dificultad correcta.
- [ ] Todas seleccionables (sin candados en MVP).

## Archivos afectados (estimado)
- `lib/features/journey/ui/difficulty_select_screen.dart`

## Histórico
<!-- Llenar al pasar a done/ -->
