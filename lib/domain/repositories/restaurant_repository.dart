import '../../core/failure.dart';
import '../models/menu_item.dart';
import '../models/restaurant.dart';

abstract class RestaurantRepository {
  Future<Result<List<Restaurant>>> getNearbyRestaurants();
  Future<Result<List<MenuItem>>> getMenu(String restaurantId);
  Future<Result<List<MenuItem>>> getItemsByCategory(String category);
}
