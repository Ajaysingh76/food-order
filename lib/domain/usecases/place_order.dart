import '../../core/failure.dart';
import '../models/order.dart';
import '../repositories/order_repository.dart';

class PlaceOrder {
  final OrderRepository repo;
  PlaceOrder(this.repo);

  Future<Result<Order>> call({required String restaurantId, required double amount}) {
    return repo.placeOrder(restaurantId: restaurantId, amount: amount);
  }
}
