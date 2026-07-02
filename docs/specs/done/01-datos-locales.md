# Spec 01 — Datos locales (Drift + seed)

**Estado:** backlog _(la carpeta manda)_
**Fase:** 0
**Depende de:** 00

## Objetivo
Base de datos local con Drift como única fuente de verdad (offline-first), con el
esquema del TECH §3 y un seed de lugares de Venezuela para jugar desde la instalación.

## Alcance
**Entra:**
- Tablas Drift: `places`, `puzzles`, `user_puzzles`, `users`. (`daily_challenges`,
  `achievements` se difieren a Fase 2 — declarar comentado o en spec aparte.)
- Enums: `Difficulty {novato, facil, medio, dificil, experto}` con su `pieceCount`
  (50/110/200/300/440) y `Category {naturaleza, playas, montanas, ciudades, islas}`.
- Repositories: `PlaceRepository`, `PuzzleRepository`, `UserPuzzleRepository` — leen/escriben Drift.
- Seed: ~8-10 lugares reales de Venezuela (Salto Ángel, Roraima, Los Roques, Médanos de
  Coro, Pico Bolívar, El Ávila, Morrocoy, Choroní…) con descripción, datos clave y curiosidad
  (sacar textos del `layout.pen`, pantalla Place Reveal como referencia de formato).
- Imágenes del seed empaquetadas como assets (placeholder si no hay foto real aún).

**NO entra:**
- Sync / Supabase (Fase 3).
- `board_state` se define acá (columna jsonb) pero su uso es del spec 05.

## Detalle técnico
- `core/db/app_database.dart` con Drift. `synced_at` nullable en tablas de usuario
  (campo presente desde ya aunque el sync llegue en Fase 3).
- `piece_count` se deriva de `difficulty` — no se guarda redundante salvo cache.
- Repos exponen `Stream`/`Future` tipados; la UI consume vía Riverpod providers.
- Seed: ejecutar una vez en primer arranque (flag en `users` o tabla meta).

## Criterios de aceptación
- [ ] DB se crea en primer arranque y persiste entre sesiones.
- [ ] Seed inserta los lugares; consultarlos devuelve datos completos.
- [ ] `Difficulty.medio.pieceCount == 200`.
- [ ] Repos devuelven datos tipados consumibles desde providers.

## Archivos afectados (estimado)
- `lib/core/db/app_database.dart`, `tables.dart`
- `lib/features/*/data/*_repository.dart`
- `lib/core/db/seed.dart`
- `assets/places/*`

## Histórico

### 2026-07-02 — Implementado (PR #2)
- Drift: tablas `Places`, `Puzzles`, `UserPuzzles`, `Users` (`lib/core/db/tables.dart`).
  `FactsConverter` guarda los datos clave como JSON. `boardState` y `syncedAt` presentes.
- Enums en `lib/core/domain/enums.dart`: `Difficulty` (50/110/200/300/440), `Category`, `PuzzleStatus`.
- `AppDatabase` con seed en `onCreate` (una vez). Repos + providers Riverpod
  (`PlaceRepository`, `PuzzleRepository`, `UserPuzzleRepository`).
- Seed de 8 lugares reales de Venezuela, un puzzle por dificultad (40 puzzles).
- `flutter analyze` limpio; `flutter test` 4/4 verde. 8 escenarios en
  `docs/specs/scenarios/01-datos-locales.feature`.

**Decisiones / desviaciones**
- El `.g.dart` de Drift **se commitea** (no hay codegen en CI → clonar y correr funciona).
  Se quitó `*.g.dart` del `.gitignore`.
- Fix: el `.g.dart` no veía los enums → se agregó `import '../domain/enums.dart'` en
  `app_database.dart` (el part file comparte el scope de la librería).
- **Nota diferida (finding revisor):** `Users` no tiene `syncedAt` (sí `UserPuzzles`).
  Se agrega con su migración cuando se construya el SyncEngine (Fase 3) — YAGNI ahora.
- Imágenes de lugares: solo se guarda la ruta; fotos = tarea de contenido (spec 03).
  Ver `assets/places/README.md`.
- Ruido de tooling (`.agents/`, `.claude/skills/`, `skills-lock.json`) → ignorado.
  `.mcp.json` (MCP de Supabase, project_ref real) quedó SIN commitear — decisión del user,
  es config de Fase 3, fuera del alcance offline.
