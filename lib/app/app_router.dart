import 'package:go_router/go_router.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/views/coffee_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const CoffeePage()),
  ],
);
