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
<!-- Llenar al pasar a done/ -->
