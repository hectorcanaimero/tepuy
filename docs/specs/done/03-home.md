# Spec 03 — Pantalla Home

**Estado:** backlog _(la carpeta manda)_
**Fase:** 1
**Depende de:** 01, 02

## Objetivo
La pantalla de entrada: banner de reto diario, filtros de categoría y listado de
puzzles populares. Punto de partida del loop central.

## Alcance
**Entra:**
- **Banner Reto Diario**: imagen del lugar, nombre, nº piezas, dificultad, CTA "Jugar Ahora"
  → navega a Difficulty Select (spec 04) o directo a Play.
- **Filtros de categoría**: chips horizontales — Todos, Naturaleza, Playas, Montañas,
  Ciudades, Islas. Link "Ver Todo".
- **Listado Populares**: tarjetas con nombre, nº piezas y dificultad (datos de spec 01).
  Tap en tarjeta → Difficulty Select del puzzle.
- Header con título "TEPUY".

**NO entra:**
- El reto diario "real" con lógica de fecha (Fase 2) — acá se muestra un puzzle destacado fijo o el primero del seed.
- Pantalla "Ver Todo" completa (puede ser placeholder o reusar Collection).

## Detalle técnico
- `features/home/ui/home_screen.dart`, consume `PuzzleRepository` vía provider.
- Filtro de categoría = estado local (Riverpod) que filtra la lista.
- Tarjeta reutilizable `shared/widgets/puzzle_card.dart` (la usa también Collection).
- Badge de dificultad con color: Fácil→`success`, Media→`warning`, Difícil→`accent` (confirmar con layout).

## Criterios de aceptación
- [ ] Banner muestra un lugar del seed y navega al tocar el CTA.
- [ ] Filtrar por categoría actualiza el listado.
- [ ] Tarjetas muestran nombre + piezas + dificultad y son tappables.
- [ ] Diseño fiel a tokens (tarjetas `bg-card`, radios `lg`).

## Archivos afectados (estimado)
- `lib/features/home/ui/home_screen.dart`
- `lib/shared/widgets/puzzle_card.dart`
- `lib/features/home/home_providers.dart`

## Histórico

### 2026-07-02 — Implementado (PR #4)
- Home (`lib/features/home/ui/home_screen.dart`): banner de reto diario (lugar
  destacado + CTA a Difficulty Select), chips de categoría con filtro (Riverpod
  `Notifier`), grilla de populares con `PuzzleCard`.
- Widgets reutilizables: `PuzzleCard` y `PlaceImage` (`lib/shared/widgets/`).
  `PlaceImage` cae a gradiente por categoría si no hay foto (asset). Badge de
  dificultad con color por token (fácil→success, media→warning, difícil→accent).
- i18n ampliado: labels de categoría/dificultad vía extensiones `.localized(l10n)`
  (`lib/shared/l10n_helpers.dart`). `AppPalette.of(context)` agregado a tokens.
- Ruta `/difficulty/:puzzleId` → `/difficulty/:placeId`.
- Tests migrados a helper `test/support.dart` (DB en memoria). `flutter analyze`
  limpio; `flutter test` 6/6. 9 escenarios en `docs/specs/scenarios/03-home.feature`.

**Revisión (loop adversarial)**
- El revisor pidió cambios (2 hallazgos) → se aplicaron y reconfirmó ✅:
  1. Banner usaba `Colors.black` → cambiado a `AppPalette.overlay` (token PRD §4).
  2. Estado de error no localizado → `l10n.errorCargarLugares`.

**Decisiones / desviaciones**
- Imágenes de lugares: gradiente por categoría hasta tener fotos (tarea de contenido).
  `PlaceImage` usa `Image.asset` con `errorBuilder` → funcionará con los assets sin cambios.
- Dificultad en tarjetas de Populares: preview variado (facil/medio/dificil); la real
  se elige en Difficulty Select (spec 04). "Ver Todo" → Colección por ahora.
