# Spec 07 — Pantalla Place Reveal

**Estado:** backlog _(la carpeta manda)_
**Fase:** 1
**Depende de:** 01, 05

## Objetivo
El payoff del juego: al completar el puzzle se revela el lugar real con su info,
datos clave y curiosidad. Es lo que diferencia a Tepuy de un jigsaw genérico.

## Alcance
**Entra:**
- Encabezado "ROMPECABEZAS COMPLETADO" + nombre del lugar + ubicación (parque · estado).
- Resumen de la partida: Tiempo, Piezas, Dificultad (de la partida recién terminada).
- **Sobre este lugar**: descripción larga (de `places.description`).
- **Datos clave**: grilla de métrica+valor (de `places.facts` jsonb).
- **¿Sabías que?**: curiosidad (de `places.did_you_know`).
- CTAs: **Siguiente Rompecabezas** (otro puzzle), **Guardar en Colección** (marca/favorito), Compartir.

**NO entra:**
- XP ganado / animación de subida de nivel (Fase 2).
- Share real a redes (puede ser placeholder o share nativo simple del sistema).

## Detalle técnico
- `features/reveal/ui/place_reveal_screen.dart`.
- Recibe `puzzleId` + resultado de la partida (tiempo, dificultad) por ruta/estado.
- Carga el `Place` del repo (spec 01); render del jsonb `facts` como grilla.
- "Guardar en Colección" → marca `is_favorite`/asegura `status=completed` en `user_puzzles`.
- "Siguiente" → elige otro puzzle (siguiente del seed o sugerencia simple).

## Criterios de aceptación
- [ ] Muestra nombre, ubicación y resumen de la partida correctos.
- [ ] Renderiza descripción, datos clave (grilla) y curiosidad del lugar.
- [ ] "Guardar en Colección" persiste y se refleja en Collection (spec 08).
- [ ] "Siguiente" lleva a otra partida.

## Archivos afectados (estimado)
- `lib/features/reveal/ui/place_reveal_screen.dart`

## Histórico
<!-- Llenar al pasar a done/ -->
