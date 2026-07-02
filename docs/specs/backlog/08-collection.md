# Spec 08 — Pantalla Collection

**Estado:** backlog _(la carpeta manda)_
**Fase:** 1
**Depende de:** 01, 02

## Objetivo
La colección de puzzles del jugador: lo completado, lo en progreso y los favoritos.
Cierra el loop — es donde se ve el resultado de jugar y da motivo para volver.

## Alcance
**Entra:**
- Header: título + total de puzzles.
- Filtros: Todos, Completados, En Progreso, Favoritos.
- Stats de cabecera: nº completados, nº en progreso, mejor tiempo.
- Grilla de tarjetas: nombre, nº piezas, y **mejor tiempo** (completado) **o** **% avance** (en progreso).
- Marcar/desmarcar favorito (`heart`).
- Tap en "en progreso" → reanuda la partida (Puzzle Play, spec 05 carga `board_state`).
- Tap en completado → puede reabrir Place Reveal o rejugar.

**NO entra:**
- Logros (van en Profile, Fase 2).

## Detalle técnico
- `features/collection/ui/collection_screen.dart`.
- Consume `UserPuzzleRepository` (spec 01) vía provider; filtro = estado local.
- Reusa `shared/widgets/puzzle_card.dart` (del spec 03) con variante de tiempo/%.
- Stats = agregaciones simples sobre `user_puzzles`.

## Criterios de aceptación
- [ ] Lista puzzles del usuario con su estado correcto.
- [ ] Filtros funcionan (Todos/Completados/En Progreso/Favoritos).
- [ ] Stats de cabecera reflejan los datos reales.
- [ ] Favorito persiste; reanudar partida en progreso funciona.

## Archivos afectados (estimado)
- `lib/features/collection/ui/collection_screen.dart`
- `lib/features/collection/collection_providers.dart`

## Histórico
<!-- Llenar al pasar a done/ -->
