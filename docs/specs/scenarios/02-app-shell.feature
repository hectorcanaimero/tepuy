# language: es
Característica: App shell + navegación

  # Criterio 1: Tab bar visible y funcional en las 4 pantallas principales.
  Escenario: El tab bar aparece en las 4 pantallas principales
    Dado que la app arranca en la ruta inicial "/"
    Cuando reviso la pantalla
    Entonces veo una tab bar inferior con 4 destinos: "Inicio", "Diario", "Colección" y "Perfil"

  Escenario: Tocar cada tab navega a su pantalla correspondiente
    Dado que estoy en la pantalla "Inicio" con el tab bar visible
    Cuando toco el destino "Diario"
    Entonces se muestra la pantalla de "Diario"
    Y el tab bar sigue visible con "Diario" marcado como seleccionado

  # Criterio 2: Cambiar de tab preserva el scroll/estado de cada una.
  Escenario: Cambiar de tab preserva el estado de la pantalla anterior
    Dado que estoy en la pantalla "Inicio" y hago scroll o cambio un estado local
    Cuando cambio al tab "Colección" y luego vuelvo al tab "Inicio"
    Entonces la pantalla "Inicio" conserva el mismo estado/posición de scroll que tenía antes de salir
    Y la pantalla no se reconstruye desde cero

  Escenario: Volver a tocar el tab activo lo resetea a su raíz
    Dado que estoy en el tab "Diario" y navegué a una subpantalla dentro de ese tab
    Cuando toco de nuevo el destino "Diario" (ya seleccionado)
    Entonces la navegación de ese tab vuelve a su pantalla raíz

  # Criterio 3: Abrir Puzzle Play / Reveal ocupa toda la pantalla sin tab bar.
  Escenario: Abrir Puzzle Play oculta el tab bar
    Dado que estoy en cualquier pantalla dentro del shell
    Cuando navego a la ruta "/play/:puzzleId"
    Entonces la pantalla de Puzzle Play ocupa toda la pantalla
    Y el tab bar no está visible

  Escenario: Abrir Place Reveal oculta el tab bar
    Dado que estoy en cualquier pantalla dentro del shell
    Cuando navego a la ruta "/reveal/:puzzleId"
    Entonces la pantalla de Place Reveal ocupa toda la pantalla
    Y el tab bar no está visible

  Escenario: Abrir Difficulty Select, Settings o Journey oculta el tab bar
    Dado que estoy en cualquier pantalla dentro del shell
    Cuando navego a "/difficulty/:puzzleId", "/settings" o "/journey"
    Entonces la pantalla correspondiente ocupa toda la pantalla
    Y el tab bar no está visible

  # Criterio 4: Colores activo/inactivo según tokens.
  Escenario: El color del tab activo usa el token accent
    Dado que estoy en el tema oscuro
    Cuando el tab "Inicio" está seleccionado
    Entonces su ícono y etiqueta usan el color del token "accent" (#7C5CFC)

  Escenario: El color del tab inactivo usa el token tab-inactive
    Dado que estoy en el tema oscuro
    Cuando el tab "Diario" no está seleccionado
    Entonces su ícono y etiqueta usan el color del token "tab-inactive" (#6B7280)

  Escenario: Los colores del tab bar responden al tema claro
    Dado que la app está en tema claro
    Cuando reviso el tab bar
    Entonces el color inactivo corresponde al token "text-muted" del tema claro (#9CA3AF)
    Y el color activo sigue siendo el token "accent" (#7C5CFC)

  # Edge cases
  Escenario: El estado de la app persiste al reiniciar en un tab distinto de Inicio
    Dado que la app fue cerrada estando en el tab "Perfil"
    Cuando la app se vuelve a abrir en su ruta inicial "/"
    Entonces arranca en el tab "Inicio" (la ruta inicial del router es "/")

  Escenario: Las 4 rutas tabbeadas nunca aparecen sin el shell
    Dado que navego directamente a "/", "/daily", "/collection" o "/profile"
    Cuando la pantalla se construye
    Entonces siempre se renderiza dentro del AppScaffold con el tab bar visible

  Escenario: Las rutas de detalle no tabbeadas nunca muestran el tab bar
    Dado que navego a cualquiera de "/settings", "/journey", "/difficulty/:id", "/play/:id" o "/reveal/:id"
    Cuando la pantalla se construye
    Entonces se renderiza sin el AppScaffold y sin la tab bar inferior
