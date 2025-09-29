import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/failure.dart';
import '../../domain/models/restaurant.dart';
import '../../domain/usecases/get_restaurants.dart';

part 'restaurant_list_event.dart';
part 'restaurant_list_state.dart';

class RestaurantListBloc extends Bloc<RestaurantListEvent, RestaurantListState> {
  final GetRestaurants getRestaurants;

  RestaurantListBloc({required this.getRestaurants}) : super(const RestaurantListState.initial()) {
    on<RestaurantListRequested>(_onRequested);
    on<RestaurantListRetry>(_onRequested);
  }

  Future<void> _onRequested(
    RestaurantListEvent event,
    Emitter<RestaurantListState> emit,
  ) async {
    emit(state.copyWith(status: RestaurantListStatus.loading, error: null));
    final result = await getRestaurants();
    if (result is Success<List<Restaurant>>) {
      emit(state.copyWith(status: RestaurantListStatus.loaded, restaurants: result.data));
    } else if (result is Error<List<Restaurant>>) {
      emit(state.copyWith(status: RestaurantListStatus.failure, error: result.failure));
    }
  }
}
