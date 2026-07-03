# Spec 05 — Motor de jigsaw

**Estado:** backlog _(la carpeta manda)_
**Fase:** 1
**Depende de:** 01

## Objetivo
El corazón del juego: generar piezas reales con lengüetas a partir de una imagen,
permitir arrastrarlas/rotarlas, encajarlas con snap magnético, agruparlas y guardar/
reanudar el progreso. Todo lo demás es CRUD; esto es el producto.

## Alcance
**Entra:**
- **Generación de grilla** `cols × rows` según `pieceCount` de la dificultad.
- **Lengüetas**: cada arista interior es `tabOut`/`tabIn` (complementaria con el vecino);
  borde exterior recto. Forma = `Path` con curvas bezier (TECH §4.1).
- **Render de pieza**: recortar la textura del lugar con el path; las lengüetas toman
  overlap de la celda vecina. Pre-recortar a imágenes (no repintar paths por frame — riesgo TECH §10).
- **Interacción** (Flame embebido en widget Flutter): drag de pieza, z-index al frente,
  rotación opcional (según setting "Rotar Piezas": 0/90/180/270, doble-tap rota).
- **Snap magnético** ("Ajustar a Cuadrícula"): al soltar, si está dentro de ~15px de su
  posición correcta y rotación correcta → snap animado, marca colocada. Snap pieza-con-pieza.
- **Grupos**: piezas unidas se mueven juntas (union-find sobre adyacentes unidas).
- **Persistencia**: `board_state` (jsonb en `user_puzzles`) guarda posición/rotación/colocada
  de cada pieza → reanudar partida en progreso. Guardar progreso al pausar/salir.
- **Fin de partida**: última pieza → guarda `best_time`, calcula `stars`, navega a Reveal (spec 07).

**NO entra:**
- HUD y herramientas (cronómetro, pista, zoom, undo) → spec 06.
- XP (Fase 2). `stars` se calcula y guarda acá pero su uso visual es de otros specs.

## Detalle técnico
- `features/puzzle/engine/` : `piece_generator.dart` (paths bezier + asignación tab/in),
  `puzzle_game.dart` (FlameGame), `piece_component.dart`, `snap.dart`, `groups.dart` (union-find).
- Setting "Rotar Piezas" / "Ajustar a Cuadrícula" leídos de settings (default ON/ON en MVP).
- Imagen downscale a resolución del tablero; liberar al salir (riesgo memoria TECH §10).
- Probar 440 piezas en gama baja **dentro de este spec** (es el riesgo principal).

## Criterios de aceptación
- [ ] Genera N piezas con lengüetas complementarias que encajan visualmente.
- [ ] Arrastrar, (rotar si ON) y soltar cerca de la posición correcta hace snap.
- [ ] Piezas correctas se unen en grupos que se mueven juntos.
- [ ] Salir y volver reanuda la partida exactamente donde estaba.
- [ ] Completar guarda best_time y navega a Reveal.
- [ ] 440 piezas corren fluido en dispositivo de gama media/baja.

## Archivos afectados (estimado)
- `lib/features/puzzle/engine/*`
- `lib/features/puzzle/ui/puzzle_play_screen.dart` (contenedor del FlameGame)
- `lib/features/puzzle/data/board_state.dart`

## Histórico

### 2026-07-03 — Implementado (PR #6)
- **Motor puro** `engine/puzzle_engine.dart` (Dart, sin Flutter): grilla + lengüetas
  bezier complementarias (topología determinística), snap absoluto + merge de vecinos
  (union-find), rotación, serialización **normalizada** de board_state, `reset()`.
- `piece_painter.dart`: path bezier de la pieza + color placeholder por posición.
- `PuzzleController`: persiste en cada drop y al pausar/salir; al completar guarda
  mejor tiempo + estrellas → navega a Reveal.
- `PuzzlePlayScreen`: Stack de piezas arrastrables, snap animado, reanuda y **rejuega**
  puzzles completados. `flutter test` 21/21 (10 tests de lógica motor+controlador).

**Revisión (loop adversarial, 2 rondas) — encontró 6 cosas reales**
- [media] board_state guardaba píxeles absolutos → reanudar rompía si cambiaba el
  tamaño de pantalla. Fix: coords **normalizadas** (0..1). Test cross-size 300→600x900.
- [media] reingresar a un puzzle completado congelaba el tablero. Fix: `reset()` → rejuega.
- [baja] snap sin animar → `AnimatedPositioned`. [baja] comentario de rotación sin test → test.
- [nota] sin guardado en pausa → `WidgetsBindingObserver` + `persist()`.
- [media, ronda 2] `AnimatedPositioned` sin `key` → con la lista reordenada por
  placed/dragging, la animación se aplicaba a la pieza equivocada. Fix: `ValueKey(index)`.

**Decisiones / desviaciones (documentadas)**
- **Flame diferido**, render Flutter-nativo. Motivo: no hay fotos que recortar aún; la
  lógica dura está aislada y testeada; migrable a Flame sin tocar el motor.
- **Rotación default OFF** en MVP (motor la soporta+testea; toggle = Settings/Fase 2).
- **Perf 440 piezas NO validada** en gama baja — riesgo abierto de TECH §10, pendiente
  de prueba en dispositivo. El render Flutter-nativo es el candidato a migrar a Flame si falla.
