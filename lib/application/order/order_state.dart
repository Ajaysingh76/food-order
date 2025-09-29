part of 'order_bloc.dart';

enum OrderStatus { initial, processing, success, failure }

class OrderState extends Equatable {
  final OrderStatus status;
  final Order? order;
  final Failure? failure;

  const OrderState({required this.status, required this.order, required this.failure});

  const OrderState.initial() : status = OrderStatus.initial, order = null, failure = null;

  OrderState copyWith({OrderStatus? status, Order? order, Failure? failure}) =>
      OrderState(status: status ?? this.status, order: order ?? this.order, failure: failure);

  @override
  List<Object?> get props => [status, order, failure];
}
