import 'package:go_router/go_router.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/views/coffee_page.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/views/favorites_view.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/views/full_image_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CoffeePage(),
      routes: [
        GoRoute(
          path: 'favorites',
          name: 'favorites',
          builder: (context, state) => const FavoritesView(),
        ),
        GoRoute(
          path: 'full_image',
          name: 'fullImage',
          builder: (context, state) {
            final imagePath = state.uri.queryParameters['imagePath'] ?? '';
            final isNetwork = state.uri.queryParameters['isNetwork'] == 'true';
            return FullImageView(
              imagePath: imagePath,
              isNetwork: isNetwork,
            );
          },
        ),
      ],
    ),
  ],
);
