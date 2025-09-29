import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:foodie_flow/application/order/order_bloc.dart';
import 'package:foodie_flow/core/failure.dart';
import 'package:foodie_flow/domain/models/order.dart' as domain;
import 'package:foodie_flow/domain/usecases/place_order.dart';

class MockPlaceOrder extends Mock implements PlaceOrder {}

void main() {
  late MockPlaceOrder mockPlaceOrder;

  setUp(() {
    mockPlaceOrder = MockPlaceOrder();
  });

  const restaurantId = 'r1';

  blocTest<OrderBloc, OrderState>(
    'success path: emits [processing, success] with order id',
    build: () {
      when(() => mockPlaceOrder(restaurantId: restaurantId, amount: 25.0)).thenAnswer(
        (_) async => Success(
          domain.Order(id: 'ORD-123456', restaurantId: restaurantId, total: 25.0, createdAt: DateTime.now()),
        ),
      );
      return OrderBloc(placeOrder: mockPlaceOrder);
    },
    act: (bloc) => bloc.add(const OrderSubmitted(restaurantId: restaurantId, amount: 25.0)),
    expect: () => [
      const OrderState(status: OrderStatus.processing, order: null, failure: null),
      isA<OrderState>().having((s) => s.status, 'status', OrderStatus.success),
    ],
  );

  blocTest<OrderBloc, OrderState>(
    'failure then retry success',
    build: () {
      when(() => mockPlaceOrder(restaurantId: restaurantId, amount: 10.0))
          .thenAnswer((_) async => Error(Failure('Payment failed')));
      return OrderBloc(placeOrder: mockPlaceOrder);
    },
    act: (bloc) async {
      bloc.add(const OrderSubmitted(restaurantId: restaurantId, amount: 10.0));
      await untilCalled(() => mockPlaceOrder(restaurantId: restaurantId, amount: 10.0));
      bloc.add(const OrderRetry());
      when(() => mockPlaceOrder(restaurantId: restaurantId, amount: 10.0)).thenAnswer(
        (_) async => Success(
          domain.Order(id: 'ORD-999999', restaurantId: restaurantId, total: 10.0, createdAt: DateTime.now()),
        ),
      );
      bloc.add(const OrderSubmitted(restaurantId: restaurantId, amount: 10.0));
    },
    expect: () => [
      const OrderState(status: OrderStatus.processing, order: null, failure: null),
      isA<OrderState>().having((s) => s.status, 'status', OrderStatus.failure),
      const OrderState(status: OrderStatus.initial, order: null, failure: null),
      const OrderState(status: OrderStatus.processing, order: null, failure: null),
      isA<OrderState>().having((s) => s.status, 'status', OrderStatus.success),
    ],
  );
}
