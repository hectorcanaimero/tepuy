# Documento Técnico — Tepuy

**Versión:** 0.1
**Fecha:** 2026-06-29
**Basado en:** `docs/PRD.md` + `docs/layout.pen`
**Decisiones cerradas:** Flutter (+ Flame en puzzle) · Backend híbrido offline-first · Jigsaw con piezas reales (lengüetas)

---

## 1. Stack

| Capa | Elección | Por qué |
|---|---|---|
| UI / app | **Flutter** | 8 de 9 pantallas son UI de app (listas, tarjetas, settings). Es donde Flutter brilla. |
| Motor de juego | **Flame** (embebido solo en Puzzle Play) | Game loop, gestión de sprites/piezas, hit-testing. Se monta dentro de un widget Flutter. |
| Estado | **Riverpod** | Providers tipados, testeable, sin boilerplate de BLoC. |
| DB local | **Drift** (SQLite) | Offline-first real, queries tipadas, migraciones. |
| Backend cloud | **Supabase** | Postgres + Auth + Storage + Realtime en un solo proveedor. Encaja con híbrido. |
| Imágenes | `cached_network_image` + Supabase Storage | Cache local de fotos de lugares; packs descargables. |
| Navegación | **go_router** | Rutas declarativas, deep links (reto diario, compartir lugar). |
| i18n | **flutter_localizations + intl (ARB)** | Multiidioma desde el día 1; es-VE primer locale. |
| Tema | **ThemeData claro + oscuro** | Selector real en Settings. Ambas paletas en PRD §4 (claro derivado del oscuro). |
| Ads | **google_mobile_ads** (rewarded) | Monetización por anuncios recompensados (Fase 4). |

> Si Supabase no cierra por costos/control, la capa de sync está aislada (§6) — se
> cambia el adapter sin tocar el resto. **ponytail:** no se abstrae más de eso hasta que haga falta.

---

## 2. Arquitectura

**Offline-first.** La app SIEMPRE lee y escribe contra la DB local (Drift). El cloud
es un espejo que se sincroniza en segundo plano. El usuario nunca espera a la red para jugar.

```
┌─────────────────────────────────────────────┐
│  UI (Flutter widgets + Flame en PuzzlePlay)  │
├─────────────────────────────────────────────┤
│  Providers (Riverpod) — estado y casos de uso│
├─────────────────────────────────────────────┤
│  Repositories — única fuente de verdad       │
│     lee/escribe LOCAL, encola sync           │
├──────────────────┬──────────────────────────┤
│  Drift (SQLite)  │  SyncEngine → Supabase    │
│   [fuente local] │   [espejo remoto]         │
└──────────────────┴──────────────────────────┘
```

**Estructura de carpetas (feature-first / screaming):**

```
lib/
  core/            # theme (tokens del §4 PRD), router, db, sync, di
  features/
    home/
    puzzle/        # ← Flame vive acá
    daily/
    collection/
    profile/
    settings/
    reveal/
    journey/       # levels + difficulty select
  shared/          # widgets reutilizables (tarjetas, tab bar, etc.)
```

Cada feature: `data/` (repo + queries), `domain/` (modelos + lógica), `ui/` (pantallas + widgets).

> **ponytail:** no hay interfaces con una sola implementación ni capa de "use cases"
> ceremoniosa. El repository ES el caso de uso. Se agregan capas el día que un
> feature tenga 2+ implementaciones reales, no antes.

---

## 3. Modelo de datos

Entidades del PRD §7 → tablas. Mismo esquema en Drift (local) y Postgres (Supabase).

```
places            id, name, location, state, category, description,
                  facts (jsonb), did_you_know, image_path, created_at

puzzles           id, place_id → places, difficulty (enum),
                  piece_count   # derivado: novato50/fácil110/medio200/difícil300/experto440

user_puzzles      id, puzzle_id, status (locked|in_progress|completed),
                  best_time_ms, stars (0..3), progress_pct,
                  is_favorite, board_state (jsonb), updated_at, synced_at

daily_challenges  id, date, puzzle_id, rewards (jsonb)

users             id, username, level, xp, rank, streak_days,
                  coins, joined_at, stats (jsonb)

achievements      id, key, title, condition (jsonb), unlocked_at
```

- `board_state` (jsonb): posición/rotación/colocada de cada pieza → permite **reanudar** una partida (Collection muestra "En Progreso 60%").
- `synced_at` null = pendiente de subir. Es la base del SyncEngine (§6).
- Categorías y dificultades son **enums**, no tablas (no cambian en runtime).

---

## 4. Motor de jigsaw (el corazón)

Esta es la parte que justifica el doc. Lo demás es CRUD con buena UI.

### 4.1 Generación de piezas con lengüetas

Una grilla `cols × rows` (ej. 10×15 = 150 piezas). Cada **borde interno** entre dos
piezas tiene una lengüeta que sobresale en una pieza y entra en la otra — son
complementarios. El borde exterior del puzzle es recto.

```dart
// Cada arista interior: +1 (lengüeta sale) o -1 (entra). El vecino lleva el opuesto.
enum Edge { flat, tabOut, tabIn }

// La forma de una pieza = Path con 4 aristas. La lengüeta es una curva bezier.
Path pieceShape(double w, double h, EdgeSet e) {
  final p = Path()..moveTo(0, 0);
  _side(p, e.top,    w, horizontal: true);   // arriba
  _side(p, e.right,  h, horizontal: false);  // derecha
  _side(p, e.bottom, w, horizontal: true, reverse: true);
  _side(p, e.left,   h, horizontal: false, reverse: true);
  return p..close();
}
// _side dibuja recto si flat, o una protuberancia bezier (~20% del lado) si tab.
```

Cada pieza se renderiza recortando la textura del lugar con ese `Path` (clip + draw
del bitmap desplazado a su celda). Las lengüetas que sobresalen toman píxeles de la
celda vecina (overlap), por eso encajan visualmente.

### 4.2 Interacción (Flame + gestos)

- **Drag:** arrastrar pieza (toca-arrastra-suelta). z-index al frente mientras se mueve.
- **Rotar:** si el setting "Rotar Piezas" está ON, las piezas nacen en ángulo aleatorio (0/90/180/270) y se rotan con doble-tap o botón. Si está OFF, siempre derechas.
- **Snap magnético** ("Ajustar a Cuadrícula"): al soltar, si la pieza está dentro de un
  umbral (~15px) de su posición correcta **y** con rotación correcta → snap animado + sonido + se marca colocada. También snap pieza-con-pieza para grupos.
- **Grupos:** piezas correctamente unidas se mueven juntas (union-find sobre piezas adyacentes ya unidas).

### 4.3 HUD (del layout, Puzzle Play)

Cronómetro, contador `colocadas/total`, bandeja de piezas restantes, y herramientas:
- **Pista** (`lightbulb`): resalta dónde va una pieza random no colocada. → coste en monedas / límite por partida (decisión §8).
- **Vista previa** (`eye`): overlay translúcido de la imagen completa.
- **Zoom** in/out + pan sobre el tablero.
- **Deshacer** (`undo`): revierte la última colocación.

### 4.4 Fin de partida

Última pieza colocada → guarda `best_time`, calcula `stars` (por tiempo vs umbrales de
la dificultad), otorga XP → navega a **Place Reveal**.

---

## 5. Gamificación (lógica)

| Sistema | Cómo se computa |
|---|---|
| **XP / Nivel / Rango** | XP por puzzle = base(dificultad) × estrellas. Nivel = curva acumulada. Rango = bucket de nivel. |
| **Estrellas** | 3★ si tiempo < umbral_oro de la dificultad, 2★ < plata, 1★ completar. |
| **Racha** | `streak_days`: +1 si jugó hoy y ayer; reset si se saltó un día. Job al abrir la app. |
| **Monedas** | Recompensa de reto diario + hitos de racha (Día 3/5/7). |
| **Desbloqueos** | Difícil requiere 2★ en Medio, etc. Reglas declarativas en `condition` (jsonb) de cada nivel. |
| **Logros** | Evaluados por evento (completar, racha, tiempo < 2min). |

> La progresión NO es requisito del loop central (PRD §9). Toda esta lógica vive
> detrás de feature flags y se prende en Fase 2.

---

## 6. Sincronización (híbrido)

**Modelo: local primero, sync eventual.** Nunca bloquea el juego.

- **Escritura:** repo escribe en Drift con `synced_at = null`. Un `SyncEngine` (background)
  sube los pendientes cuando hay red.
- **Lectura:** siempre de Drift. El pull baja cambios remotos y los mergea.
- **Conflictos:** **last-write-wins por `updated_at`** para progreso de usuario (es de un
  solo dueño, conflicto raro). El contenido (places/puzzles) es read-only desde el server → sin conflicto.
- **Auth:** Supabase Auth (Apple + Google). El layout muestra "Sincronizar — Conectado",
  pero el juego corre **sin login** (cuenta anónima local, se vincula al loguearse).

```
acción usuario → repo → Drift (synced_at=null) → UI responde YA
                                  ↓ (background, si hay red)
                          SyncEngine ⇄ Supabase
```

> **ponytail:** LWW alcanza para datos de un solo usuario. CRDTs sería sobre-ingeniería
> acá. Upgrade path: si algún día hay co-op, se revisa por tabla.

---

## 7. Pipeline de contenido

Los lugares son el producto. No van hardcodeados en el binario.

- **Seed inicial:** N lugares de Venezuela empaquetados con la app (jugable offline desde la instalación).
- **Packs descargables:** lugares nuevos vía Supabase Storage (imagen) + tabla `places` (metadata). Se bajan on-demand o como "Nuevo Pack" (recompensa de racha).
- **Imágenes:** alta resolución para el puzzle, recortadas/cacheadas localmente. Una sola
  imagen por lugar genera todas las dificultades (la grilla cambia, la foto no).
- **Reto diario:** tabla `daily_challenges` con un puzzle por fecha. Se precargan N días.

---

## 8. Decisiones técnicas (resueltas)

1. **i18n:** multiidioma desde el día 1 con `flutter_localizations` + ARB. Todo texto
   visible pasa por claves de traducción; **es-VE** es el único locale cargado al inicio.
   Se monta en Fase 0 (spec 00) — no se retrofitea.
2. **Pistas:** **1 gratis por partida** (fija). Agotada → ad recompensado da +2. En el
   MVP offline el límite existe pero el ad llega en Fase 4; hasta entonces, agotada =
   deshabilitada. ⚠️ Revisar el 1 en Experto (440 piezas) con datos de abandono — es un
   número de config, no arquitectura.
3. **Monetización:** **ads recompensados** (`google_mobile_ads`), no IAP. El usuario
   mira un anuncio opcional y gana monedas/pistas. Entra en Fase 4. El MVP no lleva ads.
   Monedas se ganan (diario + racha) y se gastan en packs de lugares.
4. **Tema:** **claro + oscuro**, ambas paletas definidas en PRD §4. `ThemeData` para
   ambos desde Fase 0 (spec 00). El claro está **derivado** del oscuro (punto de partida
   sólido); diseño puede refinar los valores sin tocar código.

---

## 9. Fases de implementación

**Fase 0 — Cimientos**
Proyecto Flutter, tokens del §4 PRD como theme (claro + oscuro), i18n (ARB, es-VE),
go_router, Drift + esquema (§3), Riverpod, seed de lugares.

**Fase 1 — Loop central (MVP, PRD §9)**
Home → Difficulty Select → **Puzzle Play (motor jigsaw §4)** → Place Reveal → Collection.
Sin login, sin progresión. Valida que el juego es divertido. **Es el hito que decide todo.**

**Fase 2 — Retención**
Daily + rachas + recompensas, Profile + logros, Levels Journey (XP/rangos), Settings completo.

**Fase 3 — Cloud**
Supabase Auth, SyncEngine (§6), packs descargables, vinculación de cuenta anónima.

**Fase 4 — Negocio**
Ads recompensados (`google_mobile_ads`): ganar monedas/pistas por anuncio. Activar
tema claro (cuando diseño entregue los tokens). Analytics (PRD §8).
_(i18n y la estructura de tema ya vienen de Fase 0.)_

---

## 10. Riesgos técnicos

| Riesgo | Mitigación |
|---|---|
| Rendimiento del jigsaw a 440 piezas (Experto) | Renderizar piezas como imágenes pre-recortadas (no repintar paths cada frame). Probar en gama baja en Fase 1. |
| Memoria con imágenes de alta resolución | Downscale a la resolución del tablero; liberar al salir de la partida. |
| Snap pieza-con-pieza con grupos grandes | Union-find O(α(n)); probar con 440 piezas temprano. |
| Costo Supabase si escala | Capa de sync aislada (§1). Plan de salida documentado, no implementado. |

---

## 11. Referencias

- `docs/PRD.md` — producto y pantallas.
- `docs/layout.pen` — diseño fuente (tokens en §4 del PRD).
