# Spec 06 — HUD y herramientas de juego

**Estado:** backlog _(la carpeta manda)_
**Fase:** 1
**Depende de:** 05

## Objetivo
La capa de UI sobre el tablero: información de la partida y las herramientas que el
jugador usa para resolverla. Es lo que el layout muestra en Puzzle Play.

## Alcance
**Entra:**
- **Header**: nombre del lugar + nº de piezas + botón volver/menú.
- **Cronómetro** en vivo (`04:32`), arranca al entrar, pausa al salir.
- **Contador** de piezas colocadas (`47 / 150`).
- **Bandeja de piezas disponibles** con contador "restantes" (las no colocadas).
- **Herramientas**:
  - Pista (`lightbulb`): resalta dónde va una pieza no colocada. **1 gratis por partida**
    (fija); el contador se muestra. Agotada → en MVP se deshabilita; en Fase 4 un ad
    recompensado da +2. El número (1) es config, no hardcode disperso.
  - Vista previa (`eye`): overlay translúcido de la imagen completa mientras se mantiene.
  - Zoom in/out + pan sobre el tablero.
  - Deshacer (`undo`): revierte la última colocación.
  - Menú (`ellipsis-vertical`): reiniciar, ajustes rápidos, salir.
- **5º ítem central "Jugar"** en el tab bar durante la partida (del layout).

**NO entra:**
- El **ad recompensado** que repone pistas (+2) → Fase 4 (`google_mobile_ads`). En el
  MVP, agotada la pista de la partida, se deshabilita.
- Lógica de colocación/snap (es del spec 05); acá solo se invocan sus acciones.

> ⚠️ El límite de 1 en Experto (440 piezas) puede subir el abandono. Es una perilla de
> config para revisar con datos, no un cambio de diseño (PRD §10).

## Detalle técnico
- `features/puzzle/ui/` : `puzzle_hud.dart`, `tool_bar.dart`, `piece_tray.dart`, `puzzle_timer.dart`.
- El timer es un provider que el HUD observa; el motor (spec 05) notifica colocaciones.
- Zoom/pan: transform sobre el viewport del FlameGame.
- Undo: stack de últimas acciones de colocación en el motor.

## Criterios de aceptación
- [ ] Cronómetro corre y se pausa correctamente.
- [ ] Contador refleja en tiempo real las piezas colocadas.
- [ ] Bandeja muestra solo piezas no colocadas con su conteo.
- [ ] Pista funciona con contador de límite por partida; al agotarse se deshabilita.
- [ ] Preview, zoom y undo funcionan.

## Archivos afectados (estimado)
- `lib/features/puzzle/ui/puzzle_hud.dart`, `tool_bar.dart`, `piece_tray.dart`, `puzzle_timer.dart`

## Histórico

### 2026-07-03 — Implementado (PR #7)
- HUD sobre `PuzzlePlayScreen`: barra superior (nombre, cronómetro en vivo que pausa
  con el ciclo de vida, menú ⋮ Reiniciar/Salir, volver) y barra inferior (contador
  colocadas/total, restantes, herramientas).
- Herramientas: pista (1 gratis/partida, resalta el home), vista previa (overlay de
  la solución), zoom in/out, **pan** (arrastre en espacio vacío), deshacer (stack).
- Todo localizado; colores sobre overlay por token (`AppPalette.textOnOverlay`).
- `flutter test` 22/22 (hud_test a 400x900). 14 escenarios.

**Revisión (loop adversarial, 2 rondas)**
- [media] faltaba pan → agregado (GestureDetector de fondo + Transform.translate).
- [media] faltaba menú ⋮ → agregado (Reiniciar/Salir).
- [menor] tooltips hardcodeados → ARB. [menor] Colors.white → token.
- **Bug real hallado al testear**: la barra superior hacía overflow (~27px) en tamaño
  teléfono → se movió el contador al bottom bar; sin overflow. Re-review → ✅.

**Decisiones / desviaciones (documentadas)**
- **Bandeja de piezas**: el motor usa scatter en el tablero (spec 05), no bandeja
  separada; el HUD muestra el contador de "restantes". Migrar a tray-drag = rediseño.
- **5º ítem 'Jugar' del tab bar NO se agrega**: la pantalla de juego es full-screen
  (arquitectura del spec 02); un nav tab bar la contradice.
- **Pendiente (sugerencias no bloqueantes del review)**: clamp/recentrado del pan;
  confirmación al salir. Ad que repone pistas = Fase 4.
