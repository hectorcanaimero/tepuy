import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/app_database.dart';
import '../../../core/domain/enums.dart';
import '../../../core/theme/tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/l10n_helpers.dart';
import '../../../shared/widgets/place_image.dart';
import '../../../shared/widgets/puzzle_card.dart';
import '../difficulty_providers.dart';

/// Elegir la dificultad de un lugar antes de jugar. Define el nº de piezas.
/// En el MVP todas las dificultades están desbloqueadas (los candados del layout
/// son Fase 2 / Levels Journey).
class DifficultySelectScreen extends ConsumerStatefulWidget {
  const DifficultySelectScreen({super.key, required this.placeId});

  final String placeId;

  @override
  ConsumerState<DifficultySelectScreen> createState() =>
      _DifficultySelectScreenState();
}

class _DifficultySelectScreenState
    extends ConsumerState<DifficultySelectScreen> {
  Difficulty _selected = Difficulty.medio;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final placeAsync = ref.watch(placeByIdProvider(widget.placeId));
    final bestTimes = ref.watch(bestTimesProvider(widget.placeId)).value;

    return Scaffold(
      appBar: AppBar(),
      body: placeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.errorCargarLugares)),
        data: (place) {
          if (place == null) {
            return Center(child: Text(l10n.errorCargarLugares));
          }
          return _Body(
            place: place,
            selected: _selected,
            bestTimes: bestTimes,
            onSelect: (d) => setState(() => _selected = d),
            onPlay: () => context.push(
              '/play/${widget.placeId}-${_selected.name}',
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.place,
    required this.selected,
    required this.bestTimes,
    required this.onSelect,
    required this.onPlay,
  });

  final Place place;
  final Difficulty selected;
  final Map<Difficulty, int?>? bestTimes;
  final ValueChanged<Difficulty> onSelect;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              PlaceImage(
                place: place,
                height: 160,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              const SizedBox(height: 12),
              Text(place.name, style: Theme.of(context).textTheme.headlineSmall),
              Text(
                place.location,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPalette.of(context).textMuted,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.seleccionaDificultad,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              for (final d in Difficulty.values)
                _DifficultyTile(
                  difficulty: d,
                  bestMs: bestTimes?[d],
                  selected: d == selected,
                  onTap: () => onSelect(d),
                ),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onPlay,
                child: Text(l10n.jugar),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DifficultyTile extends StatelessWidget {
  const _DifficultyTile({
    required this.difficulty,
    required this.bestMs,
    required this.selected,
    required this.onTap,
  });

  final Difficulty difficulty;
  final int? bestMs;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = AppPalette.of(context);
    final color = difficultyColor(context, difficulty);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: p.bgCard,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: selected ? p.accent : p.border,
                width: selected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(width: 10, height: 10, decoration: BoxDecoration(
                  color: color, shape: BoxShape.circle,
                )),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        difficulty.localized(l10n),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        l10n.piezas(difficulty.pieceCount),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: p.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  bestMs != null
                      ? l10n.mejorTiempo(formatDuration(bestMs!))
                      : l10n.sinRecord,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: bestMs != null ? p.textSecondary : p.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
