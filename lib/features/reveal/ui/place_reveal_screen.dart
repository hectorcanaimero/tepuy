import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/app_database.dart';
import '../../../core/db/providers.dart';
import '../../../core/db/tables.dart' show Fact;
import '../../../core/theme/tokens.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/l10n_helpers.dart';
import '../../../shared/widgets/place_image.dart';
import '../../home/home_providers.dart';
import '../reveal_providers.dart';

/// El payoff: al completar el puzzle se revela el lugar con su info y datos.
class PlaceRevealScreen extends ConsumerStatefulWidget {
  const PlaceRevealScreen({super.key, required this.puzzleId});

  final String puzzleId;

  @override
  ConsumerState<PlaceRevealScreen> createState() => _PlaceRevealScreenState();
}

class _PlaceRevealScreenState extends ConsumerState<PlaceRevealScreen> {
  bool _saved = false;

  Future<void> _save() async {
    await ref
        .read(userPuzzleRepositoryProvider)
        .setFavorite(widget.puzzleId, true);
    if (!mounted) return;
    setState(() => _saved = true);
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.guardadoEnColeccion)),
    );
  }

  void _next(List<Place> places, String currentPlaceId) {
    if (places.isEmpty) return context.go('/');
    final i = places.indexWhere((p) => p.id == currentPlaceId);
    final next = places[(i + 1) % places.length];
    context.pushReplacement('/difficulty/${next.id}');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dataAsync = ref.watch(revealDataProvider(widget.puzzleId));
    return Scaffold(
      body: dataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.errorCargarLugares)),
        data: (data) {
          if (data == null) {
            return Center(child: Text(l10n.errorCargarLugares));
          }
          final places = ref.watch(placesProvider).value ?? const [];
          return _Body(
            data: data,
            l10n: l10n,
            saved: _saved,
            onSave: _save,
            onNext: () => _next(places, data.place.id),
            onShare: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.compartirProximamente)),
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.data,
    required this.l10n,
    required this.saved,
    required this.onSave,
    required this.onNext,
    required this.onShare,
  });

  final RevealData data;
  final AppLocalizations l10n;
  final bool saved;
  final VoidCallback onSave;
  final VoidCallback onNext;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final theme = Theme.of(context);
    final place = data.place;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              PlaceImage(place: place, height: 260),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, p.overlay],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 4,
                child: SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop(),
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
                    Text(
                      l10n.rompecabezasCompletado,
                      style: TextStyle(
                        color: p.accentLight,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place.name,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${place.location} · ${place.state}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    if (data.stars > 0) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          for (var i = 0; i < 3; i++)
                            Icon(
                              i < data.stars ? Icons.star : Icons.star_border,
                              color: p.warning,
                              size: 22,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList.list(
            children: [
              Row(
                children: [
                  _Stat(
                    label: l10n.tiempoLabel,
                    value: data.bestTimeMs != null
                        ? formatDuration(data.bestTimeMs!)
                        : '—',
                  ),
                  _Stat(
                    label: l10n.piezasSummary,
                    value: '${data.difficulty.pieceCount}',
                  ),
                  _Stat(
                    label: l10n.dificultadLabel,
                    value: data.difficulty.localized(l10n),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _SectionTitle(l10n.sobreEsteLugar),
              const SizedBox(height: 8),
              Text(place.description, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 24),
              _SectionTitle(l10n.datosClave),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final f in place.facts) _FactCard(fact: f),
                ],
              ),
              const SizedBox(height: 24),
              _SectionTitle(l10n.sabiasQue),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(place.didYouKnow, style: theme.textTheme.bodyMedium),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onNext,
                child: Text(l10n.siguienteRompecabezas),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: saved ? null : onSave,
                icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
                label: Text(l10n.guardarEnColeccion),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: onShare,
                icon: const Icon(Icons.share_outlined),
                label: Text(l10n.compartir),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: Theme.of(context).textTheme.titleLarge);
}

class _FactCard extends StatelessWidget {
  const _FactCard({required this.fact});
  final Fact fact;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: p.bgCard,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fact.value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: p.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(fact.label, style: TextStyle(color: p.textMuted, fontSize: 12)),
        ],
      ),
    );
  }
}
