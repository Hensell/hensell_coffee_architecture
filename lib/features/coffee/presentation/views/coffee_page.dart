import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/fetch_random_coffee_image_url.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/save_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/views/coffee_view.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoffeeCubit>(
      create: (context) => CoffeeCubit(
        fetchRandomCoffeeImageUrl: FetchRandomCoffeeImageUrl(
          context.read<CoffeeRepository>(),
        ),
        saveFavorite: SaveFavorite(
          context.read<CoffeeRepository>(),
        ),
        getFavorites: GetFavorites(context.read<CoffeeRepository>()),
      ),
      child: const CoffeeView(),
    );
  }
}
