# language: es
Característica: Pantalla Home

  Escenario: El banner de Reto Diario muestra un lugar del seed y navega al tocar el CTA
    Dado que la app arrancó con la base de datos local (seed) poblada
    Cuando abro la pantalla Home
    Entonces veo el banner de Reto Diario con el nombre de un lugar del seed, su número de piezas y su dificultad
    Y veo el botón "Jugar Ahora"
    Cuando toco el botón "Jugar Ahora"
    Entonces navego a la ruta "/difficulty/:placeId" del lugar mostrado en el banner

  Escenario: Filtrar por categoría actualiza el listado de Populares
    Dado que estoy en la pantalla Home con lugares de varias categorías (Naturaleza, Montañas, Playas, etc.)
    Cuando toco el chip de categoría "Playas"
    Entonces el listado de Populares solo muestra tarjetas de lugares de categoría "Playas"
    Y los lugares de otras categorías (por ejemplo Monte Roraima, de Montañas) ya no aparecen

  Escenario: Volver a "Todos" restaura el listado completo
    Dado que filtré Populares por una categoría específica
    Cuando toco el chip "Todos"
    Entonces el listado de Populares vuelve a mostrar lugares de todas las categorías

  Escenario: Las tarjetas de Populares muestran nombre, piezas y dificultad, y son tappables
    Dado que estoy en la pantalla Home
    Entonces cada tarjeta de la sección Populares muestra el nombre del lugar, el número de piezas y un badge de dificultad
    Cuando toco una tarjeta de Populares
    Entonces navego a "/difficulty/:placeId" del lugar de esa tarjeta

  Escenario: El diseño de las tarjetas es fiel a los tokens del tema
    Dado que estoy en la pantalla Home en tema oscuro
    Entonces las tarjetas de Populares usan el color de fondo `bg-card` del tema activo
    Y las tarjetas tienen esquinas con radio `lg` (16)
    Cuando cambio a tema claro
    Entonces las tarjetas usan el `bg-card` del tema claro sin colores fijos fuera de la paleta

  Escenario: Todo el texto visible de Home está localizado (es-VE)
    Dado que el locale de la app es es-VE
    Cuando abro la pantalla Home
    Entonces el título, los textos del banner, los nombres de categoría, "Populares", "Ver Todo" y los badges de dificultad se resuelven vía AppLocalizations
    Y ningún texto visible proviene de un literal hardcodeado en el widget

  # Edge cases
  Escenario: Home no depende de conectividad (offline-first)
    Dado que el dispositivo está sin conexión a internet
    Cuando abro la pantalla Home
    Entonces el banner, las categorías y Populares se cargan igual desde la base de datos local

  Escenario: "Ver Todo" navega a Colección
    Dado que estoy en la pantalla Home
    Cuando toco el link "Ver Todo" junto a Categorías
    Entonces navego a la pantalla de Colección ("/collection")

  Escenario: Home sin lugares no rompe el banner
    Dado que la base de datos local no tiene lugares cargados
    Cuando abro la pantalla Home
    Entonces no se muestra el banner de Reto Diario
    Y la sección Populares se muestra vacía sin errores visibles
