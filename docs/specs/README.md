# Specs — Tepuy

Specs de implementación, gestionados **por carpeta**. La carpeta donde vive el
archivo ES su estado. No hay tool ni base de datos: mover el archivo cambia el estado.

```
backlog/   por hacer
doing/     en progreso (máximo 1-2 a la vez)
done/      hecho — con ## Histórico lleno
```

## Flujo

1. Un spec nace en `backlog/`.
2. Al empezar a trabajarlo → `mv` a `doing/`.
3. Al terminar → `mv` a `done/` **y** llenar la sección `## Histórico` con:
   qué se hizo, decisiones tomadas, desviaciones del plan, fecha.

Ver estado de todo:
```
eza --tree docs/specs
```

## Convención

- Un spec = un archivo = una unidad de trabajo entregable de forma independiente.
- Nombre: `NN-slug.md` (NN = orden sugerido).
- Cada spec declara de qué otros specs **depende** → eso da el orden real.
- El campo `Estado:` dentro del archivo es informativo; **la carpeta manda**.

## Alcance actual: Offline-first (Fase 0 + Fase 1)

Cubre el loop central del PRD §9 sin cloud:
Home → Difficulty Select → Puzzle Play → Place Reveal → Collection.

| # | Spec | Fase | Depende de |
|---|------|------|-----------|
| 00 | Cimientos del proyecto | 0 | — |
| 01 | Datos locales (Drift + seed) | 0 | 00 |
| 02 | App shell + navegación | 1 | 00 |
| 03 | Pantalla Home | 1 | 01, 02 |
| 04 | Pantalla Difficulty Select | 1 | 01, 02 |
| 05 | Motor de jigsaw | 1 | 01 |
| 06 | HUD y herramientas de juego | 1 | 05 |
| 07 | Pantalla Place Reveal | 1 | 01, 05 |
| 08 | Pantalla Collection | 1 | 01, 02 |

Cloud, retención y monetización (Fases 2-4 del TECH) se especifican cuando lleguemos.

## Referencias

- `docs/PRD.md` · `docs/TECH.md` · `docs/layout.pen`
