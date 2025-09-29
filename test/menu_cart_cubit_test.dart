import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:foodie_flow/application/menu_cart/menu_cart_cubit.dart';
import 'package:foodie_flow/core/failure.dart';
import 'package:foodie_flow/domain/models/menu_item.dart';
import 'package:foodie_flow/domain/usecases/get_menu.dart';

class MockGetMenu extends Mock implements GetMenu {}

void main() {
  late MockGetMenu mockGetMenu;
  const restaurantId = 'test_restaurant';
  
  setUp(() {
    mockGetMenu = MockGetMenu();
  });

  final menu = [
    const MenuItem(id: '1', restaurantId: 'r1', name: 'Burger', description: 'Tasty', price: 10.0, category: 'Burger', imageUrl: 'test.jpg'),
    const MenuItem(id: '2', restaurantId: 'r1', name: 'Pizza', description: 'Cheesy', price: 15.0, category: 'Pizza', imageUrl: 'test.jpg'),
  ];

  blocTest<MenuCartCubit, MenuCartState>(
    'loads menu successfully',
    build: () {
      when(() => mockGetMenu(restaurantId)).thenAnswer((_) async => Success(menu));
      return MenuCartCubit(getMenu: mockGetMenu, restaurantId: restaurantId);
    },
    act: (cubit) => cubit.loadMenu(),
    expect: () => [
      MenuCartState.initial(restaurantId).copyWith(status: MenuCartStatus.loading, failure: null),
      MenuCartState.initial(restaurantId).copyWith(status: MenuCartStatus.loaded, menu: menu),
    ],
  );

  test('adding items updates total correctly', () async {
    when(() => mockGetMenu(restaurantId)).thenAnswer((_) async => Success(menu));
    final cubit = MenuCartCubit(getMenu: mockGetMenu, restaurantId: restaurantId);
    await cubit.loadMenu();
    cubit.addItem(menu[0]); // +10
    cubit.addItem(menu[1]); // +5.5
    cubit.addItem(menu[0]); // +10 => total 25.5
    expect(cubit.state.cart.total, 25.5);
    cubit.removeItem(menu[0]); // -10 => 15.5
    expect(cubit.state.cart.total, 15.5);
  });

  blocTest<MenuCartCubit, MenuCartState>(
    'emits failure on menu error',
    build: () {
      when(() => mockGetMenu(restaurantId)).thenAnswer((_) async => Error(Failure('net')));
      return MenuCartCubit(getMenu: mockGetMenu, restaurantId: restaurantId);
    },
    act: (cubit) => cubit.loadMenu(),
    expect: () => [
      MenuCartState.initial(restaurantId).copyWith(status: MenuCartStatus.loading, failure: null),
      isA<MenuCartState>().having((s) => s.status, 'status', MenuCartStatus.failure),
    ],
  );
}
