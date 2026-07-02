# Spec 02 — App shell + navegación

**Estado:** backlog _(la carpeta manda)_
**Fase:** 1
**Depende de:** 00

## Objetivo
La cáscara de la app: tab bar inferior persistente y la status bar, sobre la que se
montan las pantallas. Refleja la navegación del layout.

## Alcance
**Entra:**
- Tab bar inferior de 4 ítems: **Inicio · Diario · Colección · Perfil** (iconos lucide:
  `house`, `calendar`, `grid-2x2`/`layout-grid`, `user`).
- Color activo `accent #7C5CFC`, inactivo `tab-inactive #6B7280`.
- `ShellRoute` de go_router que mantiene el tab bar entre pantallas tabbeadas.
- Pantallas no-tabbeadas (Puzzle Play, Place Reveal, Difficulty Select, Settings, Journey)
  se abren full-screen **sin** tab bar (push sobre el shell).
- Status bar styling (claro sobre fondo oscuro).

**NO entra:**
- Contenido de cada pantalla (specs propios).
- El 5º ítem central "Jugar" que aparece durante la partida → lo maneja Puzzle Play (spec 06).

## Detalle técnico
- `shared/widgets/app_scaffold.dart` con `NavigationBar` (Material 3) estilizado a tokens.
- `ShellRoute` envuelve `/`, `/daily`, `/collection`, `/profile`.
- Rutas de detalle (`/play/...`, `/reveal/...`, `/difficulty/...`) fuera del shell.
- Preservar estado de cada tab (no recrear al cambiar) → `StatefulShellRoute.indexedStack`.

## Criterios de aceptación
- [ ] Tab bar visible y funcional en las 4 pantallas principales.
- [ ] Cambiar de tab preserva el scroll/estado de cada una.
- [ ] Abrir Puzzle Play / Reveal ocupa toda la pantalla sin tab bar.
- [ ] Colores activo/inactivo según tokens.

## Archivos afectados (estimado)
- `lib/shared/widgets/app_scaffold.dart`
- `lib/core/router/app_router.dart` (StatefulShellRoute)

## Histórico

### 2026-07-02 — Implementado (PR #3)
- `AppScaffold` (`lib/shared/widgets/app_scaffold.dart`) con `NavigationBar`:
  Inicio · Diario · Colección · Perfil, labels vía i18n.
- Router (`lib/core/router/app_router.dart`) migrado a `StatefulShellRoute.indexedStack`:
  4 branches tabbeados con estado preservado; rutas de detalle (settings, journey,
  difficulty, play, reveal) fuera del shell → full-screen sin tab bar.
- Tab bar estilado por tokens en el theme (`navigationBarTheme`): activo `accent`,
  inactivo `textMuted` (= tab-inactive del PRD §4), indicador `accentGlow`.
- Status bar claro sobre fondo oscuro (`SystemChrome` en `main.dart`).
- `flutter analyze` limpio; `flutter test` 5/5. 13 escenarios en
  `docs/specs/scenarios/02-app-shell.feature`.

**Decisiones / desviaciones**
- **Íconos (finding):** el spec pedía lucide, pero `lucide_icons` 0.257 **rompe con
  Flutter 3.44** (extiende `IconData`, ahora `final`) — `flutter analyze` no lo detecta
  pero el compilador de tests sí. Se usaron **Material Icons** equivalentes (bundleados).
  Pendiente: evaluar `lucide_icons_flutter` (fork mantenido) cuando hagan falta glifos
  específicos del diseño (eye, lightbulb, mountain… en specs 05-07).
- Placeholders del router siguen con títulos hardcodeados (descartables, cada spec los
  reemplaza) — misma desviación aceptada del spec 00.
