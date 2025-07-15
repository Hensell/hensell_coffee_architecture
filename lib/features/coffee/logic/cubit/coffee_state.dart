part of 'coffee_cubit.dart';

sealed class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object?> get props => [];
}

final class CoffeeInitial extends CoffeeState {}

final class CoffeeLoading extends CoffeeState {}

final class CoffeeLoaded extends CoffeeState {
  const CoffeeLoaded(this.imageUrl);
  final String imageUrl;

  @override
  List<Object?> get props => [imageUrl];
}

final class CoffeeError extends CoffeeState {
  const CoffeeError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

final class FavoritesLoading extends CoffeeState {}

final class FavoritesLoaded extends CoffeeState {
  const FavoritesLoaded(this.favorites);
  final List<CoffeeFavorite> favorites;

  @override
  List<Object?> get props => [favorites];
}

final class FavoritesError extends CoffeeState {
  const FavoritesError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
