import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/app_database.dart';
import '../../../core/domain/enums.dart';
import '../../../core/theme/tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/l10n_helpers.dart';
import '../../../shared/widgets/place_image.dart';
import '../../../shared/widgets/puzzle_card.dart';
import '../home_providers.dart';

/// Dificultades que se muestran en las tarjetas de "Populares" (variedad como el
/// layout). La dificultad real se elige en Difficulty Select al tocar la tarjeta.
const _popularDifficulties = [
  Difficulty.facil,
  Difficulty.medio,
  Difficulty.dificil,
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final placesAsync = ref.watch(placesProvider);

    return Scaffold(
      body: SafeArea(
        child: placesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (places) => _HomeContent(places: places, l10n: l10n),
        ),
      ),
    );
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent({required this.places, required this.l10n});

  final List<Place> places;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(categoryFilterProvider);
    final populars = filter == null
        ? places
        : places.where((p) => p.category == filter).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Text(l10n.appTitle, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        if (places.isNotEmpty) _DailyBanner(place: places.first, l10n: l10n),
        const SizedBox(height: 24),
        _SectionHeader(
          title: l10n.categorias,
          action: l10n.verTodo,
          onAction: () => context.go('/collection'),
        ),
        const SizedBox(height: 12),
        _CategoryChips(selected: filter),
        const SizedBox(height: 24),
        _SectionHeader(title: l10n.populares),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.82,
          children: [
            for (final (i, place) in populars.indexed)
              PuzzleCard(
                place: place,
                difficulty:
                    _popularDifficulties[i % _popularDifficulties.length],
                onTap: () => context.push('/difficulty/${place.id}'),
              ),
          ],
        ),
      ],
    );
  }
}

class _DailyBanner extends StatelessWidget {
  const _DailyBanner({required this.place, required this.l10n});

  final Place place;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    const difficulty = Difficulty.medio;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Stack(
        children: [
          PlaceImage(place: place, height: 200),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Pill(text: l10n.retoDiario, color: AppPalette.of(context).accent),
                const SizedBox(height: 8),
                Text(
                  place.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${l10n.piezas(difficulty.pieceCount)} · ${difficulty.localized(l10n)}',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => context.push('/difficulty/${place.id}'),
                  child: Text(l10n.jugarAhora),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (action != null)
          TextButton(onPressed: onAction, child: Text(action!)),
      ],
    );
  }
}

class _CategoryChips extends ConsumerWidget {
  const _CategoryChips({required this.selected});

  final Category? selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(categoryFilterProvider.notifier);
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ChoiceChip(
            label: Text(l10n.filtroTodos),
            selected: selected == null,
            onSelected: (_) => notifier.select(null),
          ),
          const SizedBox(width: 8),
          for (final category in Category.values) ...[
            ChoiceChip(
              label: Text(category.localized(l10n)),
              selected: selected == category,
              onSelected: (_) => notifier.select(category),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
