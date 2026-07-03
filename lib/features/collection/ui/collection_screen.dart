import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/providers.dart';
import '../../../core/domain/enums.dart';
import '../../../core/theme/tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/puzzle_card.dart';
import '../collection_providers.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final itemsAsync = ref.watch(collectionProvider);
    return Scaffold(
      body: SafeArea(
        child: itemsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(child: Text(l10n.errorCargarLugares)),
          data: (items) => _Content(items: items, l10n: l10n),
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({required this.items, required this.l10n});

  final List<CollectionItem> items;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(collectionFilterProvider);
    final completed = items
        .where((i) => i.userPuzzle.status == PuzzleStatus.completed)
        .toList();
    final inProgress = items
        .where((i) => i.userPuzzle.status == PuzzleStatus.inProgress)
        .toList();
    final bestMs = completed
        .map((i) => i.userPuzzle.bestTimeMs)
        .whereType<int>()
        .fold<int?>(null, (a, b) => a == null ? b : (b < a ? b : a));

    final filtered = switch (filter) {
      CollectionFilter.todos => items,
      CollectionFilter.completados => completed,
      CollectionFilter.enProgreso => inProgress,
      CollectionFilter.favoritos =>
        items.where((i) => i.userPuzzle.isFavorite).toList(),
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Text(l10n.miColeccion, style: Theme.of(context).textTheme.headlineMedium),
        Text(
          l10n.totalPuzzles(items.length),
          style: TextStyle(color: AppPalette.of(context).textMuted),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _Stat(value: '${completed.length}', label: l10n.filtroCompletados),
            _Stat(value: '${inProgress.length}', label: l10n.filtroEnProgreso),
            _Stat(
              value: bestMs != null ? formatDuration(bestMs) : '—',
              label: l10n.statMejorTiempo,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _FilterChips(selected: filter),
        const SizedBox(height: 16),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Center(
              child: Text(
                l10n.coleccionVacia,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppPalette.of(context).textMuted),
              ),
            ),
          )
        else
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.78,
            children: [
              for (final item in filtered)
                _CollectionCard(item: item),
            ],
          ),
      ],
    );
  }
}

class _CollectionCard extends ConsumerWidget {
  const _CollectionCard({required this.item});

  final CollectionItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final up = item.userPuzzle;
    final done = up.status == PuzzleStatus.completed;
    final note = done
        ? (up.bestTimeMs != null ? formatDuration(up.bestTimeMs!) : null)
        : l10n.progresoPct((up.progressPct * 100).round());

    return PuzzleCard(
      place: item.place,
      difficulty: item.difficulty,
      note: note,
      isFavorite: up.isFavorite,
      onFavorite: () => ref
          .read(userPuzzleRepositoryProvider)
          .setFavorite(item.puzzleId, !up.isFavorite),
      onTap: () => context.push(
        done ? '/reveal/${item.puzzleId}' : '/play/${item.puzzleId}',
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: TextStyle(color: p.textMuted, fontSize: 12)),
        ],
      ),
    );
  }
}

class _FilterChips extends ConsumerWidget {
  const _FilterChips({required this.selected});

  final CollectionFilter selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(collectionFilterProvider.notifier);
    final labels = {
      CollectionFilter.todos: l10n.filtroTodos,
      CollectionFilter.completados: l10n.filtroCompletados,
      CollectionFilter.enProgreso: l10n.filtroEnProgreso,
      CollectionFilter.favoritos: l10n.filtroFavoritos,
    };
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final f in CollectionFilter.values) ...[
            ChoiceChip(
              label: Text(labels[f]!),
              selected: selected == f,
              onSelected: (_) => notifier.select(f),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
