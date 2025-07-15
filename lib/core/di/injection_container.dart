import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_database.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_local_data_source.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/datasources/coffee_remote_data_source.dart';
import 'package:hensell_coffee_architecture/features/coffee/data/repositories/coffee_repository_impl.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/repositories/coffee_repository.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/fetch_random_coffee_image_url.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/get_favorites.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/remove_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/usecases/save_favorite.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_favorites_cubit.dart';

class InjectionContainer extends StatelessWidget {
  const InjectionContainer({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CoffeeRepository>(
          create: (_) => CoffeeRepositoryImpl(
            localDataSource: CoffeeLocalDataSource(CoffeeDatabase()),
            remoteDataSource: CoffeeRemoteDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CoffeeCubit>(
            create: (context) => CoffeeCubit(
              fetchRandomCoffeeImageUrl: FetchRandomCoffeeImageUrl(
                context.read<CoffeeRepository>(),
              ),
              saveFavorite: SaveFavorite(
                context.read<CoffeeRepository>(),
              ),
              getFavorites: GetFavorites(context.read<CoffeeRepository>()),
            ),
          ),
          BlocProvider<CoffeeFavoritesCubit>(
            create: (context) => CoffeeFavoritesCubit(
              getFavorites: GetFavorites(
                context.read<CoffeeRepository>(),
              ),
              removeFavorite: RemoveFavorite(
                context.read<CoffeeRepository>(),
              ),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
