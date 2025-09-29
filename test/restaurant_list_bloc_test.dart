import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:foodie_flow/application/restaurant_list/restaurant_list_bloc.dart';
import 'package:foodie_flow/core/failure.dart';
import 'package:foodie_flow/domain/models/restaurant.dart';
import 'package:foodie_flow/domain/usecases/get_restaurants.dart';

class MockGetRestaurants extends Mock implements GetRestaurants {}

void main() {
  late MockGetRestaurants mockGetRestaurants;

  setUp(() {
    mockGetRestaurants = MockGetRestaurants();
  });

  final restaurants = [
    const Restaurant(id: 'r1', name: 'A', imageUrl: 'u', rating: 4.2, distanceText: '1 km'),
  ];

  blocTest<RestaurantListBloc, RestaurantListState>(
    'emits [loading, loaded] when fetch succeeds',
    build: () {
      when(() => mockGetRestaurants()).thenAnswer((_) async => Success(restaurants));
      return RestaurantListBloc(getRestaurants: mockGetRestaurants);
    },
    act: (bloc) => bloc.add(RestaurantListRequested()),
    expect: () => [
      const RestaurantListState(status: RestaurantListStatus.loading, restaurants: [], error: null),
      RestaurantListState(status: RestaurantListStatus.loaded, restaurants: restaurants, error: null),
    ],
  );

  blocTest<RestaurantListBloc, RestaurantListState>(
    'emits [loading, failure] when fetch fails then retry succeeds',
    build: () {
      when(() => mockGetRestaurants()).thenAnswer((_) async => Error(Failure('net', code: 'network')));
      return RestaurantListBloc(getRestaurants: mockGetRestaurants);
    },
    act: (bloc) async {
      bloc.add(RestaurantListRequested());
      await untilCalled(() => mockGetRestaurants());
      // Next call should succeed
      when(() => mockGetRestaurants()).thenAnswer((_) async => Success(restaurants));
      bloc.add(RestaurantListRetry());
    },
    expect: () => [
      const RestaurantListState(status: RestaurantListStatus.loading, restaurants: [], error: null),
      isA<RestaurantListState>().having((s) => s.status, 'status', RestaurantListStatus.failure),
      const RestaurantListState(status: RestaurantListStatus.loading, restaurants: [], error: null),
      RestaurantListState(status: RestaurantListStatus.loaded, restaurants: restaurants, error: null),
    ],
  );
}
