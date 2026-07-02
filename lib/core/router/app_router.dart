import 'package:go_router/go_router.dart';

import '../../features/home/ui/home_screen.dart';
import '../../shared/widgets/placeholder_screen.dart';

/// Rutas de la app. Las pantallas placeholder se reemplazan en sus specs.
/// El tab bar / ShellRoute llega en el spec 02.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
    GoRoute(
      path: '/daily',
      builder: (_, _) => const PlaceholderScreen(title: 'Diario'),
    ),
    GoRoute(
      path: '/collection',
      builder: (_, _) => const PlaceholderScreen(title: 'Colección'),
    ),
    GoRoute(
      path: '/profile',
      builder: (_, _) => const PlaceholderScreen(title: 'Perfil'),
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
