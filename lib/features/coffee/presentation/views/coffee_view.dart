import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/widgets/coffee_image_and_actions.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/widgets/no_internet_view.dart';
import 'package:hensell_coffee_architecture/l10n/gen/app_localizations.dart';

class CoffeeView extends StatefulWidget {
  const CoffeeView({super.key});

  @override
  State<CoffeeView> createState() => _CoffeeViewState();
}

class _CoffeeViewState extends State<CoffeeView> {
  @override
  void initState() {
    super.initState();
    context.read<CoffeeCubit>().loadRandomCoffeeImage();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.hensellCoffeeArchitecture),
        centerTitle: true,
      ),
      body: BlocListener<CoffeeCubit, CoffeeState>(
        listener: (context, state) {
          if (state is FavoriteSavedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                key: const Key('snackbar_saved_to_favorites'),
                content: Text(l10n.savedToFavorites),
              ),
            );
          } else if (state is FavoriteSavedExists) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.savedToFavoritesExists)),
            );
          } else if (state is CoffeeError) {
            String errorMsg;
            switch (state.message) {
              case 'no_internet_save_failed':
                errorMsg = l10n.noInternetSaveFailed;
              default:
                errorMsg = l10n.noInternetButFavorites;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMsg)),
            );
          }
        },
        child: BlocBuilder<CoffeeCubit, CoffeeState>(
          builder: (context, state) {
            if (state is CoffeeLoading) {
              return CoffeeImageAndActions(loading: true, l10n: l10n);
            }
            if (state is CoffeeLoaded) {
              return CoffeeImageAndActions(
                imageUrl: state.imageUrl,
                l10n: l10n,
              );
            }
            if (state is CoffeeError &&
                (state.message == 'no_internet' ||
                    state.message == 'no_internet_save_failed') &&
                !kIsWeb) {
              return NoInternetView(l10n: l10n);
            }

            return Center(
              child: FilledButton.icon(
                onPressed: () {
                  context.read<CoffeeCubit>().loadRandomCoffeeImage();
                },
                icon: const Icon(Icons.coffee),
                label: Text(l10n.discoverCoffee),
              ),
            );
          },
        ),
      ),
    );
  }
}
