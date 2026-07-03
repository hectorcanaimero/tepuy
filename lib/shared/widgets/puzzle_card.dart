import 'package:flutter/material.dart';

import '../../core/db/app_database.dart';
import '../../core/domain/enums.dart';
import '../../core/theme/tokens.dart';
import '../../l10n/app_localizations.dart';
import '../l10n_helpers.dart';
import 'place_image.dart';

/// Color del badge de dificultad (PRD/layout): fácil→success, media→warning,
/// difícil→accent.
Color difficultyColor(BuildContext context, Difficulty d) {
  final p = AppPalette.of(context);
  return switch (d) {
    Difficulty.novato || Difficulty.facil => p.success,
    Difficulty.medio => p.warning,
    Difficulty.dificil || Difficulty.experto => p.accent,
  };
}

/// Tarjeta de un puzzle (lugar × dificultad). Reutilizada por Home y Colección.
class PuzzleCard extends StatelessWidget {
  const PuzzleCard({
    super.key,
    required this.place,
    required this.difficulty,
    this.onTap,
    this.note,
    this.isFavorite,
    this.onFavorite,
  });

  final Place place;
  final Difficulty difficulty;
  final VoidCallback? onTap;

  /// Línea extra bajo las piezas (ej. mejor tiempo o "% completado").
  final String? note;

  /// Corazón de favorito (solo si `onFavorite` != null).
  final bool? isFavorite;
  final VoidCallback? onFavorite;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final p = AppPalette.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                PlaceImage(place: place, height: 104),
                if (onFavorite != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      iconSize: 20,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        (isFavorite ?? false)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: (isFavorite ?? false) ? p.accent : Colors.white,
                      ),
                      onPressed: onFavorite,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.piezas(difficulty.pieceCount),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: p.textMuted,
                          ),
                        ),
                      ),
                      _DifficultyBadge(difficulty: difficulty),
                    ],
                  ),
                  if (note != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      note!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: p.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  const _DifficultyBadge({required this.difficulty});

  final Difficulty difficulty;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final color = difficultyColor(context, difficulty);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        difficulty.localized(l10n),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
