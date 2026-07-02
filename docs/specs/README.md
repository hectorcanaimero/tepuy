# Specs — Tepuy

Specs de implementación, gestionados **por carpeta**. La carpeta donde vive el
archivo ES su estado. No hay tool ni base de datos: mover el archivo cambia el estado.

```
backlog/   por hacer
doing/     en progreso (máximo 1-2 a la vez)
done/      hecho — con ## Histórico lleno
```

## Flujo (spec → feature → PR)

Cada spec es **un feature** y entra por **un PR**. Nunca se codea directo a `main`.

1. Spec nace en `backlog/`.
2. Al empezar → `mv` a `doing/` **y** crear rama `feat/NN-slug` (ej. `feat/00-cimientos`).
3. Implementar en la rama. Commits conventional (`feat(cimientos): ...`).
4. Abrir **PR** contra `main` (título conventional, referenciando el spec).
5. **El agente `spec-pr-reviewer` revisa el PR**: valida el código contra el spec y
   escribe los escenarios de validación en Gherkin → `docs/specs/scenarios/NN-slug.feature`.
   Se invoca automáticamente al abrir cada PR.
6. Con la revisión OK y los escenarios verdes → **merge**.
7. Post-merge → `mv` el spec a `done/` **y** llenar `## Histórico` (qué se hizo,
   decisiones, desviaciones, fecha).

Un spec en `doing/` = una rama/PR viva. Máximo 1-2 a la vez.

Ver estado de todo:
```
eza --tree docs/specs
```

### Escenarios de validación
- Los escribe el agente, en **Gherkin (español)**, uno por Criterio de aceptación.
- Viven en `docs/specs/scenarios/NN-slug.feature`.
- Cuando exista el proyecto Flutter, se mapean a `integration_test/` casi 1:1.

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
