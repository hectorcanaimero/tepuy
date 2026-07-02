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
<!-- Llenar al pasar a done/ -->
