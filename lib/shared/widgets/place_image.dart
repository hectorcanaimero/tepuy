import 'package:flutter/material.dart';

import '../../core/db/app_database.dart';
import '../../core/domain/enums.dart';
import '../../core/theme/tokens.dart';

/// Imagen de un lugar. Si la foto (asset) no existe todavía, cae a un gradiente
/// por categoría — las fotos reales son tarea de contenido (assets/places).
/// Cuando se agreguen y se declaren en pubspec, este widget las usa sin cambios.
class PlaceImage extends StatelessWidget {
  const PlaceImage({
    super.key,
    required this.place,
    this.height,
    this.borderRadius,
  });

  final Place place;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      place.imagePath,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => _fallback(context),
    );
    if (borderRadius == null) return image;
    return ClipRRect(borderRadius: borderRadius!, child: image);
  }

  Widget _fallback(BuildContext context) {
    final p = AppPalette.of(context);
    final color = switch (place.category) {
      Category.naturaleza => p.success,
      Category.montanas => p.accentLight,
      Category.playas => p.accent,
      Category.islas => p.warning,
      Category.ciudades => p.textSecondary,
    };
    final icon = switch (place.category) {
      Category.naturaleza => Icons.forest_outlined,
      Category.montanas => Icons.terrain_outlined,
      Category.playas => Icons.beach_access_outlined,
      Category.islas => Icons.water_outlined,
      Category.ciudades => Icons.location_city_outlined,
    };
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.55), p.bgCard],
        ),
      ),
      child: Icon(icon, color: color.withValues(alpha: 0.85), size: 40),
    );
  }
}
