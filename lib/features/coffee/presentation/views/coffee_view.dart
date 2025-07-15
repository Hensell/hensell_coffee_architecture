import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
import 'package:hensell_coffee_architecture/features/coffee/domain/entities/coffee_favorite.dart';

class CoffeeView extends StatelessWidget {
  const CoffeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeCubit, CoffeeState>(
      builder: (context, state) {
        if (state is CoffeeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CoffeeError) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        }

        if (state is CoffeeLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                state.imageUrl,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<CoffeeCubit>().loadRandomCoffeeImage();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Otra imagen'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // Aquí deberías llamar saveCurrentAsFavorite con los datos correctos
                  // Esto depende de si ya tienes localPath/plataforma/createdAt disponibles
                },
                icon: const Icon(Icons.favorite),
                label: const Text('Guardar como favorito'),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/favorites');
                },
                icon: const Icon(Icons.list),
                label: const Text('Ver favoritos'),
              ),
            ],
          );
        }

        return Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<CoffeeCubit>().loadRandomCoffeeImage();
            },
            child: const Text('Descubrir café'),
          ),
        );
      },
    );
  }
}
