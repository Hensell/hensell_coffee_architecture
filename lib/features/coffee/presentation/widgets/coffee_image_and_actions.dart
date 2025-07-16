import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_cubit.dart';
import 'package:hensell_coffee_architecture/l10n/gen/app_localizations.dart';

class CoffeeImageAndActions extends StatelessWidget {
  const CoffeeImageAndActions({
    required this.l10n,
    this.loading = false,
    super.key,
    this.imageUrl,
  });

  final String? imageUrl;
  final bool loading;
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ClipRRect(
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
                        color: Colors.grey[300],
                        child: loading
                            ? const Center(child: CircularProgressIndicator())
                            : imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: imageUrl!,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.broken_image, size: 64),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : const SizedBox.shrink(),
                      ),
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
                  ),
                  FilledButton.icon(
                    onPressed: loading || imageUrl == null
                        ? null
                        : () async {
                            final cubit = context.read<CoffeeCubit>();
                            final currentState = cubit.state;
                            if (currentState is CoffeeLoaded) {
                              await cubit.saveCurrentAsFavorite(
                                originalUrl: currentState.imageUrl,
                              );
                            }
                          },
                    icon: const Icon(Icons.favorite),
                    label: Text(l10n.saveAsFavorite),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.pink.shade700,
                      foregroundColor: Colors.white,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
