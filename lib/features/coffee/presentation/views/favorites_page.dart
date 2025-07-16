import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/remove_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_favorites_cubit.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/views/favorites_view.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoffeeFavoritesCubit>(
      create: (context) => CoffeeFavoritesCubit(
        getFavorites: GetFavorites(context.read<CoffeeRepository>()),
        removeFavorite: RemoveFavorite(context.read<CoffeeRepository>()),
      ),
      child: const FavoritesView(),
    );
  }
}
