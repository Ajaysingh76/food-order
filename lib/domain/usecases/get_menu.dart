import '../../core/failure.dart';
import '../models/menu_item.dart';
import '../repositories/restaurant_repository.dart';

class GetMenu {
  final RestaurantRepository repo;
  GetMenu(this.repo);

  Future<Result<List<MenuItem>>> call(String restaurantId) => repo.getMenu(restaurantId);
}
