part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class OrderSubmitted extends OrderEvent {
  final String restaurantId;
  final double amount;
  const OrderSubmitted({required this.restaurantId, required this.amount});

  @override
  List<Object?> get props => [restaurantId, amount];
}

class OrderRetry extends OrderEvent {
  const OrderRetry();
}
