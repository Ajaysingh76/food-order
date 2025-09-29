import '../../core/failure.dart';
import '../models/menu_item.dart';
import '../repositories/restaurant_repository.dart';

class GetItemsByCategory {
  final RestaurantRepository repository;

  GetItemsByCategory(this.repository);

  Future<Result<List<MenuItem>>> call(String category) {
    return repository.getItemsByCategory(category);
  }
}
