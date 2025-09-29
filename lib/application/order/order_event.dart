part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

// For future backend use
class OrderSubmitted extends OrderEvent {
  final String restaurantId;
  final double amount;

  const OrderSubmitted({required this.restaurantId, required this.amount});

  @override
  List<Object?> get props => [restaurantId, amount];
}

// Used for instant success in the prototype
class OrderPlaced extends OrderEvent {
  final double amount;

  const OrderPlaced({required this.amount});

  @override
  List<Object?> get props => [amount];
}

class OrderRetry extends OrderEvent {
  const OrderRetry();
}
