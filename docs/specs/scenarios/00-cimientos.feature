# language: es
Característica: Cimientos del proyecto (spec 00)
  Como base del juego Tepuy, la app arranca con el design system del PRD §4
  cargado como theme, i18n es-VE activo, navegación declarativa y estructura
  feature-first. Cada escenario mapea 1:1 a un criterio de aceptación del spec.

  Antecedentes:
    Dado que la app Tepuy está instalada y se ejecuta offline

  Escenario: La app arranca en tema oscuro con bg-primary de fondo
    Dado que el themeMode configurado es oscuro
    Cuando se levanta la app con "flutter run"
    Entonces se muestra la pantalla Home sin errores
    Y el color de fondo del Scaffold es el token bg-primary oscuro "#0A0A0F"

  Escenario: Navegar entre las rutas placeholder funciona
    Dado que estoy en la ruta "/" (Home)
    Cuando toco el botón "Ir a Diario"
    Entonces la app navega a la ruta "/daily"
    Y se muestra la pantalla placeholder correspondiente
    Cuando toco el botón "Ir a Colección" desde Home
    Entonces la app navega a la ruta "/collection"

  Escenario: Todas las rutas placeholder de las 9 pantallas resuelven
    Dado que el router declara las rutas de las 9 pantallas del MVP
    Cuando navego a "/", "/daily", "/collection", "/profile", "/settings", "/journey", "/difficulty/1", "/play/1" y "/reveal/1"
    Entonces cada ruta renderiza una pantalla sin lanzar excepción

  Escenario: Un texto visible se resuelve vía AppLocalizations y no está hardcodeado
    Dado que el locale activo es es-VE
    Cuando se muestra la pantalla Home
    Entonces el título "TEPUY" proviene de la clave AppLocalizations.appTitle
    Y el tagline muestra el texto en español "Armá el rompecabezas, descubrí el lugar"

  Escenario: El tema claro aplica la paleta clara del PRD §4 sin romper nada
    Dado que la app tiene cableados los ThemeData oscuro y claro
    Cuando el themeMode cambia a claro
    Entonces el color de fondo del Scaffold es el token bg-primary claro "#F7F7FB"
    Y la app sigue funcionando sin errores de render
    Cuando el themeMode vuelve a oscuro
    Entonces el color de fondo del Scaffold es el token bg-primary oscuro "#0A0A0F"

  Escenario: Los colores del theme salen de los tokens del PRD §4 (no hex sueltos)
    Dado que el theme se construye desde AppPalette y AppRadius
    Cuando inspecciono el color de acento (accent) en cualquiera de los dos temas
    Entonces coincide con el token "#7C5CFC" del PRD §4
    Y el radio "md" de las tarjetas coincide con el valor 12 del PRD §4

  Escenario: La estructura de carpetas feature-first está creada
    Dado que reviso el árbol de lib/
    Entonces existen los directorios "core/", "features/" y "shared/"
    Y el theme vive en "core/theme/" y el router en "core/router/"

  Escenario: El repo git está inicializado con .gitignore de Flutter
    Dado que reviso la raíz del proyecto
    Entonces existe un repositorio git inicializado
    Y existe un ".gitignore" que ignora "build/", ".dart_tool/" y artefactos de Flutter

  # Edge case (offline-first): fuente Inter vía google_fonts
  Escenario: En arranque offline sin cache de fuente la app no se rompe
    Dado que no hay conexión de red y la fuente Inter aún no está cacheada
    Cuando se levanta la app
    Entonces la app renderiza usando la fuente de fallback del sistema
    Y no se produce ningún crash por el fetch de la fuente
