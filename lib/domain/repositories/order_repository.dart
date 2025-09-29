import '../../core/failure.dart';
import '../models/order.dart';

abstract class OrderRepository {
  Future<Result<Order>> placeOrder({
    required String restaurantId,
    required double amount,
  });
}
