import 'dart:async';
import 'dart:math';

import '../core/failure.dart';
import '../domain/models/order.dart';
import '../domain/repositories/order_repository.dart';

class FakeOrderRepository implements OrderRepository {
  final Random _rng;
  FakeOrderRepository({Random? rng}) : _rng = rng ?? Random();

  @override
  Future<Result<Order>> placeOrder({
    required String restaurantId,
    required double amount,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    // 25% chance of payment failure
    if (_rng.nextDouble() < 0.25) {
      return Error(Failure('Payment failed. Please try again.', code: 'payment_failed'));
    }
    final order = Order(
      id: 'ORD-' + (_rng.nextInt(900000) + 100000).toString(),
      restaurantId: restaurantId,
      total: amount,
      createdAt: DateTime.now(),
    );
    return Success(order);
  }
}
