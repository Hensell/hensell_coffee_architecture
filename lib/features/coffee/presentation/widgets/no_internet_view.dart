import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
import 'package:hensell_coffee_architecture/l10n/gen/app_localizations.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({required this.l10n, super.key});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off, size: 48, color: Colors.red.shade300),
              const SizedBox(height: 24),
              Text(
                l10n.noInternetButFavorites,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  GoRouter.of(context).push('/favorites');
                },
                icon: const Icon(Icons.list),
                label: Text(l10n.viewFavorites),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.refresh),
                label: Text(l10n.tryAgain),
                onPressed: () {
                  context.read<CoffeeCubit>().loadRandomCoffeeImage();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
