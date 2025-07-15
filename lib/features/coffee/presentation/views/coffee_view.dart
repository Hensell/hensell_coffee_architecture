import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
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
      appBar: AppBar(title: Text(l10n.hensellCoffeeArchitecture)),
      body: BlocListener<CoffeeCubit, CoffeeState>(
        listener: (context, state) {
          if (state is FavoriteSavedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.savedToFavorites)),
            );
          }

          if (state is FavoriteSavedExists) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.savedToFavoritesExists)),
            );
          }
          if (state is CoffeeError && state.message != 'no_internet') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<CoffeeCubit, CoffeeState>(
          builder: (context, state) {
            if (state is CoffeeLoading) {
              return _CoffeeImageAndActions(
                loading: true,
                l10n: l10n,
              );
            }
            if (state is CoffeeLoaded) {
              return _CoffeeImageAndActions(
                imageUrl: state.imageUrl,
                l10n: l10n,
              );
            }
            if (state is CoffeeError &&
                state.message == 'no_internet' &&
                !kIsWeb) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wifi_off,
                        size: 48,
                        color: Colors.red.shade300,
                      ),
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
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: Text(l10n.tryAgain),
                        onPressed: () {
                          context.read<CoffeeCubit>().loadRandomCoffeeImage();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Center(
              child: FilledButton.icon(
                onPressed: () {
                  context.read<CoffeeCubit>().loadRandomCoffeeImage();
                },
                icon: const Icon(Icons.coffee),
                label: Text(l10n.discoverCoffee),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CoffeeImageAndActions extends StatelessWidget {
  const _CoffeeImageAndActions({
    required this.l10n,
    this.imageUrl,
    this.loading = false,
  });
  final String? imageUrl;
  final bool loading;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: InkWell(
                onTap: imageUrl != null
                    ? () {
                        GoRouter.of(context).pushNamed(
                          'fullImage',
                          queryParameters: {
                            'imagePath': imageUrl,
                            'isNetwork': 'true',
                          },
                        );
                      }
                    : null,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.grey[300],
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 64),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: loading
                    ? null
                    : () {
                        context.read<CoffeeCubit>().loadRandomCoffeeImage();
                      },
                icon: const Icon(Icons.refresh),
                label: Text(l10n.anotherImage),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              FilledButton.icon(
                onPressed: loading || imageUrl == null
                    ? null
                    : () async {
                        final currentState = context.read<CoffeeCubit>().state;
                        if (currentState is CoffeeLoaded) {
                          await context
                              .read<CoffeeCubit>()
                              .saveCurrentAsFavorite(
                                originalUrl: currentState.imageUrl,
                              );
                        }
                      },
                icon: const Icon(Icons.favorite),
                label: Text(l10n.saveAsFavorite),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.pink.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: loading
                    ? null
                    : () {
                        GoRouter.of(context).push('/favorites');
                      },
                icon: const Icon(Icons.list),
                label: Text(l10n.viewFavorites),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
