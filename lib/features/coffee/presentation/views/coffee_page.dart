import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/views/coffee_view.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoffeeCubit>.value(
      value: context.read<CoffeeCubit>()..loadRandomCoffeeImage(),
      child: CoffeeView(),
    );
  }
}
