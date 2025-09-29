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
    on<OrderRetry>(_onRetry);
  }

  Future<void> _onSubmit(OrderSubmitted event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.processing, failure: null));
    final result = await placeOrder(restaurantId: event.restaurantId, amount: event.amount);
    if (result is Success<Order>) {
      emit(state.copyWith(status: OrderStatus.success, order: result.data));
    } else if (result is Error<Order>) {
      emit(state.copyWith(status: OrderStatus.failure, failure: result.failure));
    }
  }

  void _onRetry(OrderRetry event, Emitter<OrderState> emit) {
    emit(const OrderState.initial());
  }
}
