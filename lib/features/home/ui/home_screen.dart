import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';

/// Home placeholder (spec 00): confirma theme + i18n + navegación.
/// El contenido real (banner diario, categorías, populares) es el spec 03.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.appTitle, style: theme.textTheme.displaySmall),
              const SizedBox(height: 12),
              Text(
                l10n.homeTagline,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => context.go('/daily'),
                child: Text(l10n.goToDaily),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => context.go('/collection'),
                child: Text(l10n.goToCollection),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
