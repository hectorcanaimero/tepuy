# Imágenes de lugares

Cada lugar del seed referencia `assets/places/{id}.jpg` (ver `lib/core/db/seed.dart`).

Las fotos reales son una **tarea de contenido pendiente** (como la paleta de tema
claro). El spec 01 NO carga imágenes — solo guarda la ruta. El wiring de imagen +
`cached_network_image` llega en el **spec 03 (Home)**.

Al agregar las fotos: declarar `assets/places/` en `pubspec.yaml` bajo `flutter: assets:`.
