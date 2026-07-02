# PRD — Tepuy

**Versión:** 0.1 (derivado de `docs/layout.pen`)
**Fecha:** 2026-06-29
**Estado:** Borrador para revisión
**Plataforma:** Mobile (iOS primero; layout a 390pt — iPhone)

> Este PRD se deriva *exactamente* del layout de diseño. Lo que el diseño no definía
> se resolvió con el equipo y quedó cerrado en **§10 Decisiones**.

---

## 1. Resumen

Tepuy es un juego de rompecabezas (jigsaw) para móvil ambientado en lugares de
Venezuela. El jugador arma el puzzle de una foto de un lugar real; al completarlo
se le **revela el lugar** con su nombre, ubicación, datos clave y curiosidades.

El gancho no es solo armar el puzzle: es **descubrir y coleccionar lugares** —
mezcla juego casual + contenido educativo/cultural + progresión gamificada.

**Una frase:** *Armá el rompecabezas, descubrí el lugar.*

---

## 2. Objetivos

- Entregar un juego de jigsaw fluido en móvil con dificultad escalable (50 → 440 piezas).
- Convertir cada partida completada en un momento de descubrimiento (pantalla *Place Reveal*).
- Retención mediante reto diario, rachas y un camino de progresión por niveles/XP.
- Construir una colección de lugares que el jugador quiera completar.

**No-objetivos (de esta versión, según el layout):** multijugador, editor de
puzzles propios, contenido fuera de Venezuela. (Confirmar — ver §10.)

---

## 3. Usuario y plataforma

- **Idioma:** Multiidioma con i18n **desde el día 1**. **es-VE** es el primer (y
  único cargado) locale; las pantallas en inglés del layout eran bocetos. La
  arquitectura intl/ARB queda lista para sumar idiomas sin refactor.
- **Dispositivo:** iPhone (ancho 390pt). Status bar nativa visible en todas las pantallas.
- **Navegación:** Tab bar inferior de 4 ítems — **Inicio · Diario · Colección · Perfil**.
  Durante una partida el tab bar agrega un 5º ítem central: **Jugar**.

---

## 4. Sistema de diseño (tokens del layout)

| Categoría | Token | Oscuro | Claro |
|---|---|---|---|
| Fondo | `bg-primary` | `#0A0A0F` | `#F7F7FB` |
| Fondo | `bg-secondary` | `#151520` | `#FFFFFF` |
| Tarjeta | `bg-card` | `#1C1C2A` | `#FFFFFF` |
| Tarjeta hover | `bg-card-hover` | `#252538` | `#F0F0F5` |
| Acento | `accent` | `#7C5CFC` | `#7C5CFC` |
| Acento claro | `accent-light` | `#A78BFA` | `#A78BFA` |
| Glow | `accent-glow` | `#7C5CFC33` | `#7C5CFC22` |
| Éxito | `success` | `#34D399` | `#10B981` |
| Aviso | `warning` | `#FBBF24` | `#D97706` |
| Texto | `text-primary` | `#FFFFFF` | `#0A0A0F` |
| Texto | `text-secondary` | `#9CA3AF` | `#4B5563` |
| Texto | `text-muted` | `#6B7280` | `#9CA3AF` |
| Borde | `border` | `#2A2A3D` | `#E5E7EB` |
| Overlay | `overlay` | `#0A0A0F99` | `#0A0A0F66` |
| Tipografía | `font-main` | Inter | Inter |
| Radios | `sm / md / lg / xl / full` | 8 / 12 / 16 / 20 / 9999 | (igual) |

- **Tema:** oscuro **+ claro**, ambos definidos arriba. El oscuro viene del layout;
  el claro está **derivado** de los roles del oscuro (acento y tipografía se mantienen).
  Es un punto de partida sólido — diseño puede refinarlo, pero el dev no está bloqueado.
- **Iconografía:** librería **Lucide**.

---

## 5. Pantallas y funcionalidades

### 5.1 Home (`Inicio`)
- Banner **Reto Diario** destacado (ej. *Salto Ángel · 150 piezas · Media*) con CTA **Jugar Ahora**.
- **Categorías** con filtros: Todos, Naturaleza, Playas, Montañas, Ciudades, Islas. Link **Ver Todo**.
- Listado **Populares**: tarjeta con nombre del lugar, nº de piezas y dificultad
  (ej. Monte Roraima 100/Fácil, Los Roques 200/Media, Médanos de Coro 300/Difícil).

### 5.2 Puzzle Play (`Jugar`)
El tablero de juego. Header: nombre + nº de piezas. HUD:
- **Cronómetro** en vivo (`04:32`).
- **Progreso** de piezas colocadas (`47 / 150`).
- **Bandeja de piezas disponibles** con contador (`103 restantes`).
- **Herramientas:** pista (`lightbulb`), deshacer (`undo`), rotar (`rotate-cw`),
  zoom in/out, vista previa de la imagen (`eye`), referencia/grid (`grid-2x2`, `REF`),
  menú adicional (`ellipsis-vertical`).

### 5.3 Daily (`Diario`)
- **Reto de Hoy** destacado (lugar + piezas + dificultad + Jugar Ahora).
- **Racha** visible (ej. *7 Días*) con vista semanal Lun–Dom.
- **Recompensas de la semana** por día: Monedas (Día 3), Nuevo Pack (Día 5),
  Caja Misteriosa (Día 7) — con estado bloqueado/desbloqueado.
- **Retos pasados**: historial con fecha, piezas y tiempo de resolución.

### 5.4 Collection (`Colección`)
- Grilla de puzzles con filtros: Todos, Completados, En Progreso, Favoritos.
- Stats de cabecera: nº completados, nº en progreso, mejor tiempo.
- Tarjeta por puzzle: nombre, nº de piezas, y mejor tiempo **o** % de avance.
- Marcar favoritos (`heart`).

### 5.5 Profile (`Perfil`)
- Identidad: avatar, usuario, **Nivel + rango** (ej. *Nivel 12 — Experto*), fecha de alta.
- **Stats:** Completados, Tiempo total, Racha, Piezas totales.
- **Logros** (con bloqueados): Primera, En Racha, Veloz, etc. + **Ver Todo**.
- Accesos rápidos: Notificaciones, Sonidos, Tema, Ayuda y Soporte, Compartir App.

### 5.6 Settings (`Ajustes`)
- **Juego:** Dificultad, nº de Piezas, Mostrar Cronómetro, Rotar Piezas, Ajustar a Cuadrícula (snap).
- **Notificaciones:** Recordatorio Diario, Nuevos Rompecabezas, Alerta de Racha.
- **Apariencia:** Tema, Ícono de App, Idioma.
- **Cuenta:** Sincronizar (estado *Conectado*), Privacidad, Términos, Calificar App, Cerrar Sesión.
- Versión de app visible en el pie (ej. *Tepuy v2.4.1*).

### 5.7 Place Reveal
Pantalla post-completado — el payoff del juego:
- Encabezado **Rompecabezas Completado** + nombre y ubicación del lugar.
- Resumen de la partida: Tiempo, Piezas, Dificultad.
- **Sobre este lugar** (descripción larga).
- **Datos clave** (grilla de métricas: altura, año, etc.).
- **¿Sabías que?** (curiosidad).
- CTAs: **Siguiente Rompecabezas**, **Guardar en Colección**, Compartir.

### 5.8 Levels Journey (`Tu Camino`)
- Progresión por **XP** con barra (ej. *1.240 / 2.000 XP · 760 para Nivel 13*).
- Rango (ej. *Maestro Tepuy*). Resumen: Estrellas (6/15), Racha, Niveles.
- **Camino de dificultad**: Novato → Fácil → Medio → Difícil → Experto, con nodo
  ACTUAL, nodos bloqueados y nº de piezas por tramo.
- **Próxima recompensa** con condición de desbloqueo (ej. *Completá Medio con 3 estrellas*).

### 5.9 Difficulty Select
- Selección de dificultad para un reto: **Novato 50 · Fácil 110 · Medio 200 · Difícil 300 · Experto 440** piezas.
- Por nivel: mejor tiempo, **XP que otorga**, y estado bloqueado con condición
  (ej. *Conseguí 2★ en Medio* para desbloquear Difícil).
- CTA **Jugar** sobre el nivel seleccionable.

---

## 6. Sistemas transversales (gamificación)

| Sistema | Evidencia en el layout |
|---|---|
| **Dificultad** | 5 niveles, 50→440 piezas (Novato/Fácil/Medio/Difícil/Experto) |
| **XP y Niveles** | Barra de XP, "X para Nivel N", rangos (Experto, Maestro Tepuy) |
| **Estrellas** | Por desempeño en cada nivel (ej. 3★), condición de desbloqueo |
| **Rachas** | Conteo de días consecutivos, alerta de racha |
| **Monedas** | Recompensa diaria (50 Monedas) |
| **Packs / Cajas Misteriosas** | Recompensas de racha semanal |
| **Logros** | Primera, En Racha, Veloz… (con bloqueados) |
| **Colección** | Lugares guardados como meta de completitud |

---

## 7. Modelo de contenido (entidades)

- **Lugar (Place):** nombre, ubicación (parque/estado), descripción, datos clave
  (lista de métrica+valor), curiosidad ("¿Sabías que?"), categoría, imagen.
- **Puzzle:** referencia a un Lugar + dificultad → define nº de piezas. Mejor tiempo, estado.
- **Categoría:** Naturaleza, Playas, Montañas, Ciudades, Islas.
- **Reto Diario:** Puzzle del día + fecha + recompensas asociadas.
- **Usuario:** perfil, nivel/XP/rango, racha, monedas, stats agregadas, colección, logros.

---

## 8. Métricas de éxito (propuestas — confirmar)

- D1 / D7 retention; longitud de racha promedio.
- % de partidas completadas vs abandonadas.
- Puzzles completados por usuario / semana.
- Tasa de llegada a *Place Reveal* y a "Guardar en Colección".

---

## 9. Alcance MVP sugerido

**Dentro:** Home, Puzzle Play (motor jigsaw + herramientas), Place Reveal,
Collection, Difficulty Select, Settings, catálogo inicial de lugares de Venezuela.

**Fase 2:** Daily + rachas + recompensas, Profile completo con logros,
Levels Journey (XP/rangos), sincronización de cuenta.

> Razón: el loop central (elegir → armar → revelar → coleccionar) es jugable sin
> el sistema de progresión. La gamificación amplifica retención pero no es
> requisito para validar el core.

---

## 10. Decisiones (resueltas)

| # | Tema | Decisión |
|---|------|----------|
| 1 | **Idioma** | Multiidioma con i18n desde el día 1; **es-VE** primer locale. |
| 2 | **Monetización** | **Ads recompensados** (rewarded): el usuario mira un anuncio opcional y gana monedas/pistas. Sin IAP por ahora. |
| 3 | **Backend / cuentas** | **Híbrido offline-first**. Juega sin login (cuenta anónima local), vinculable con Apple/Google para sync. |
| 4 | **Motor de jigsaw** | **Piezas reales con lengüetas** (no cuadrícula). |
| 5 | **Origen del contenido** | **Curado**: seed empaquetado + packs descargables. Sin CMS por ahora. |
| 6 | **Sistema de pistas** | **1 pista gratis por partida** (fija). Agotada → ad recompensado da +2 (Fase 4). |
| 7 | **Plataformas** | **iOS + Android** (cross-platform, Flutter). |
| 8 | **Tema** | **Claro + oscuro**, ambos definidos (§4). Oscuro del layout; claro derivado. |

### Economía (defaults — afinables con datos, no bloquean)
- **Pistas:** 1 gratis/partida; ad recompensado repone +2. ⚠️ revisar en Experto (440
  piezas) si el abandono sube — perilla de calibración, no cambio de arquitectura.
- **Monedas:** se ganan (reto diario + hitos de racha: día 3 = 50, día 5 = pack, día
  7 = caja misteriosa) y se gastan en packs de lugares. Sin IAP.

---

## 11. Referencias

- Layout fuente: `docs/layout.pen` (Pencil, 9 pantallas + 21 tokens).
- Sistema de diseño: §4.
