import 'package:get_it/get_it.dart';

import '../data/fake_order_repository.dart';
import '../data/fake_restaurant_repository.dart';
import '../domain/repositories/order_repository.dart';
import '../domain/repositories/restaurant_repository.dart';
import '../domain/usecases/get_menu.dart';
import '../domain/usecases/get_restaurants.dart';
import '../domain/use_cases/get_items_by_category.dart';
import '../domain/usecases/place_order.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Repos
  sl.registerLazySingleton<RestaurantRepository>(() => FakeRestaurantRepository());
  sl.registerLazySingleton<OrderRepository>(() => FakeOrderRepository());

  // Use-cases
  sl.registerFactory(() => GetRestaurants(sl()));
  sl.registerFactory(() => GetMenu(sl()));
  sl.registerFactory(() => GetItemsByCategory(sl()));
  sl.registerFactory(() => PlaceOrder(sl()));
}
