import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/ui/home_screen.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/placeholder_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();

/// Rutas de la app.
/// - Las 4 pantallas tabbeadas viven en un `StatefulShellRoute` (con tab bar y
///   estado preservado por tab).
/// - Las de detalle (dificultad, juego, reveal, ajustes, camino) van fuera del
///   shell → ocupan toda la pantalla, sin tab bar.
final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: '/', builder: (_, _) => const HomeScreen())],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/daily',
              builder: (_, _) => const PlaceholderScreen(title: 'Diario'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/collection',
              builder: (_, _) => const PlaceholderScreen(title: 'Colección'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (_, _) => const PlaceholderScreen(title: 'Perfil'),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (_, _) => const PlaceholderScreen(title: 'Ajustes'),
    ),
    GoRoute(
      path: '/journey',
      builder: (_, _) => const PlaceholderScreen(title: 'Tu Camino'),
    ),
    GoRoute(
      path: '/difficulty/:puzzleId',
      builder: (_, _) => const PlaceholderScreen(title: 'Dificultad'),
    ),
    GoRoute(
      path: '/play/:puzzleId',
      builder: (_, _) => const PlaceholderScreen(title: 'Jugar'),
    ),
    GoRoute(
      path: '/reveal/:puzzleId',
      builder: (_, _) => const PlaceholderScreen(title: 'Lugar'),
    ),
  ],
);
