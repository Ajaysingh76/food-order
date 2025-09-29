import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/failure.dart';
import '../../domain/models/order.dart';
import '../../domain/usecases/place_order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PlaceOrder placeOrder;

  OrderBloc({required this.placeOrder}) : super(const OrderState.initial()) {
    on<OrderSubmitted>(_onSubmit);
    on<OrderPlaced>(_onPlaced);
    on<OrderRetry>(_onRetry);
  }

  // For real backend API (not used in prototype)
  Future<void> _onSubmit(OrderSubmitted event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.processing, failure: null));

    final result = await placeOrder(
      restaurantId: event.restaurantId,
      amount: event.amount,
    );

    if (result is Success<Order>) {
      emit(state.copyWith(status: OrderStatus.success, order: result.data));
    } else if (result is Error<Order>) {
      emit(
        state.copyWith(status: OrderStatus.failure, failure: result.failure),
      );
    }
  }

  // For prototype → instant success (skips backend)
  void _onPlaced(OrderPlaced event, Emitter<OrderState> emit) {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      restaurantId: 'demo_restaurant', // hardcoded for prototype
      total: event.amount,
      createdAt: DateTime.now(),
    );

    emit(state.copyWith(status: OrderStatus.success, order: order));
  }

  void _onRetry(OrderRetry event, Emitter<OrderState> emit) {
    emit(const OrderState.initial());
  }
}
