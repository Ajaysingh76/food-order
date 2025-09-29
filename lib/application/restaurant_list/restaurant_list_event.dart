part of 'restaurant_list_bloc.dart';

sealed class RestaurantListEvent extends Equatable {
  const RestaurantListEvent();

  @override
  List<Object?> get props => [];
}

class RestaurantListRequested extends RestaurantListEvent {}

class RestaurantListRetry extends RestaurantListEvent {}
