import '../../core/failure.dart';
import '../models/restaurant.dart';
import '../repositories/restaurant_repository.dart';

class GetRestaurants {
  final RestaurantRepository repo;
  GetRestaurants(this.repo);

  Future<Result<List<Restaurant>>> call() => repo.getNearbyRestaurants();
}
