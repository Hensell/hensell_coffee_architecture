part of 'coffee_favorites_cubit.dart';

sealed class CoffeeFavoritesState extends Equatable {
  const CoffeeFavoritesState();

  @override
  List<Object?> get props => [];
}

final class CoffeeFavoritesInitial extends CoffeeFavoritesState {}

final class CoffeeFavoritesLoading extends CoffeeFavoritesState {}

final class CoffeeFavoritesLoaded extends CoffeeFavoritesState {
  const CoffeeFavoritesLoaded(this.favorites);
  final List<CoffeeFavorite> favorites;

  @override
  List<Object?> get props => [favorites];
}

final class CoffeeFavoritesError extends CoffeeFavoritesState {
  const CoffeeFavoritesError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
