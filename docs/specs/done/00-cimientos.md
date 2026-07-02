# Spec 00 — Cimientos del proyecto

**Estado:** backlog _(la carpeta manda)_
**Fase:** 0
**Depende de:** —

## Objetivo
Tener un proyecto Flutter que arranca, con el design system del layout cargado como
theme, navegación declarativa y la estructura de carpetas feature-first. Base sobre
la que se monta todo lo demás.

## Alcance
**Entra:**
- `flutter create` + `git init` en `/Users/editor2/dev/igsaw`.
- Dependencias base: `flutter_riverpod`, `go_router`, `drift` + `drift_flutter` + `sqlite3_flutter_libs`, `cached_network_image`, `flame`, `flutter_localizations` + `intl`.
- Theme con los tokens del PRD §4 (colores dark **y light**, radios, Inter) como `ThemeData` **dark Y light**. Ambas paletas están definidas en PRD §4 (la clara, derivada).
- **i18n** (ARB) desde el día 1: `flutter_localizations`, locale **es-VE** cargado, todo
  texto visible vía claves (`AppLocalizations`). Estructura lista para más idiomas.
- Estructura de carpetas `core/ features/ shared/` (TECH §2).
- Router con `go_router` y rutas placeholder de las 9 pantallas.
- Pantalla en blanco navegable que confirma que el theme y el i18n aplican.

**NO entra:**
- Lógica de pantallas (cada una en su spec).
- DB schema (spec 01).
- Flame embebido (spec 05).
- Idiomas adicionales (solo es-VE cargado).
- Selector de tema en Settings funcional (es del spec de Settings, Fase 2). Acá se
  cablean ambos `ThemeData`; el MVP corre en oscuro.

## Detalle técnico
- Tokens → un archivo `core/theme/tokens.dart` con constantes + `core/theme/app_theme.dart`
  que arma el `ThemeData` dark **y** light con las dos columnas de PRD §4
  (`bg-primary` oscuro `#0A0A0F` / claro `#F7F7FB`, etc.). Fuente Inter via google_fonts o asset.
- i18n → `l10n.yaml` + `lib/l10n/app_es.arb`. Generar `AppLocalizations`. `MaterialApp`
  con `localizationsDelegates` y `supportedLocales: [es-VE]`.
- `core/router/app_router.dart`: GoRouter con las rutas (`/`, `/difficulty/:puzzleId`,
  `/play/:puzzleId`, `/reveal/:puzzleId`, `/collection`, `/daily`, `/profile`, `/settings`, `/journey`).
- `ProviderScope` en `main.dart`.
- Radios como helpers (`AppRadius.md = 12`).

## Criterios de aceptación
- [ ] `flutter run` levanta la app en dark con `bg-primary` de fondo.
- [ ] Navegar entre rutas placeholder funciona.
- [ ] Un texto de prueba se muestra vía `AppLocalizations` (no hardcodeado).
- [ ] Cambiar el theme mode (dark/light) aplica las paletas de PRD §4 sin romper nada.
- [ ] Estructura de carpetas creada.
- [ ] Repo git inicializado con `.gitignore` de Flutter.

## Archivos afectados (estimado)
- `pubspec.yaml`, `l10n.yaml`
- `lib/main.dart`
- `lib/core/theme/tokens.dart`, `lib/core/theme/app_theme.dart`
- `lib/l10n/app_es.arb`
- `lib/core/router/app_router.dart`

## Histórico

### 2026-07-02 — Implementado (PR #1, merge 52b4b3c)
- `flutter create` (iOS + Android, org `com.hectorcanaimero`). Deps: riverpod,
  go_router, google_fonts, intl, drift + drift_flutter + sqlite3_flutter_libs,
  cached_network_image, flame, flutter_localizations.
- Theme dark + light desde `lib/core/theme/tokens.dart` (valores PRD §4, 1:1) y
  `app_theme.dart`. MVP corre en oscuro; light cableado con paleta derivada.
- i18n: `l10n.yaml` + `lib/l10n/app_es.arb` → `AppLocalizations` (locale es-VE).
- `go_router` con las 9 rutas placeholder; estructura `core/ features/ shared/`.
- Home confirma theme + i18n + navegación. `flutter analyze` limpio, `flutter test` verde.
- Escenarios de validación: `docs/specs/scenarios/00-cimientos.feature` (9, Gherkin).

**Decisiones / desviaciones**
- Conflicto `intl`: `flutter_localizations` exige `intl 0.20.2` exacto → se pineó.
- **Desviación aceptada (finding Medio del revisor):** los títulos de las pantallas
  *placeholder* en el router están hardcodeados ('Diario', 'Colección'…), no vía i18n.
  Se acepta a propósito: son descartables y cada spec (02–08) reemplaza su pantalla con
  la versión real y localizada. Agregar claves para texto que se borra sería boilerplate.
  El criterio de i18n del spec se cumple en Home. **Revisar que ningún placeholder
  sobreviva a su spec.**
- `ColorScheme.error` mapeado a `warning` (no hay token de error en el PRD).
- `google_fonts` fetchea Inter en runtime (spec lo permite; upgrade path = bundlear .ttf).
