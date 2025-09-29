part of 'restaurant_list_bloc.dart';

enum RestaurantListStatus { initial, loading, loaded, failure }

class RestaurantListState extends Equatable {
  final RestaurantListStatus status;
  final List<Restaurant> restaurants;
  final Failure? error;

  const RestaurantListState({
    required this.status,
    required this.restaurants,
    required this.error,
  });

  const RestaurantListState.initial()
      : status = RestaurantListStatus.initial,
        restaurants = const [],
        error = null;

  RestaurantListState copyWith({
    RestaurantListStatus? status,
    List<Restaurant>? restaurants,
    Failure? error,
  }) {
    return RestaurantListState(
      status: status ?? this.status,
      restaurants: restaurants ?? this.restaurants,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, restaurants, error];
}
