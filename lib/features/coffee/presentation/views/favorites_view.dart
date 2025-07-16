import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hensell_coffee_architecture/features/coffee/logic/cubit/coffee_favorites_cubit.dart';
import 'package:hensell_coffee_architecture/features/coffee/presentation/widgets/confirm_delete_dialog.dart';
import 'package:hensell_coffee_architecture/l10n/gen/app_localizations.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();
    context.read<CoffeeFavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favoritesTitle),
        centerTitle: true,
      ),
      body: BlocBuilder<CoffeeFavoritesCubit, CoffeeFavoritesState>(
        builder: (context, state) {
          if (state is CoffeeFavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CoffeeFavoritesError) {
            return Center(child: Text(state.message));
          }
          if (state is CoffeeFavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return Center(child: Text(l10n.noFavoritesYet));
            }
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final favorite = state.favorites[index];
                return ListTile(
                  onTap: () {
                    if (kIsWeb) {
                      GoRouter.of(context).pushNamed(
                        'fullImage',
                        queryParameters: {
                          'imagePath': favorite.originalUrl,
                          'isNetwork': 'true',
                        },
                      );
                    } else {
                      GoRouter.of(context).pushNamed(
                        'fullImage',
                        queryParameters: {
                          'imagePath': favorite.localPath,
                          'isNetwork': 'false',
                        },
                      );
                    }
                  },
                  leading: favorite.localPath != null
                      ? Image.file(
                          File(favorite.localPath!),
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          favorite.originalUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                  title: Text(favorite.originalUrl),
                  subtitle: Text(
                    favorite.createdAt.toString(),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      final confirmed = await showConfirmDeleteDialog(
                        context,
                        l10n,
                      );
                      if (!mounted) return;
                      if (confirmed ?? false) {
                        // We use if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        await context
                            .read<CoffeeFavoritesCubit>()
                            .removeFavoriteById(
                              favorite.id,
                            );
                      }
                    },
                  ),
                );
              },
            );
          }
          return Center(child: Text(l10n.loadingFavorites));
        },
      ),
    );
  }
}
