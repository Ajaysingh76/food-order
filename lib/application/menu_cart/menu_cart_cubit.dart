import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/failure.dart';
import '../../domain/models/cart.dart';
import '../../domain/models/menu_item.dart';
import '../../domain/usecases/get_menu.dart';

part 'menu_cart_state.dart';

class MenuCartCubit extends Cubit<MenuCartState> {
  final GetMenu getMenu;

  MenuCartCubit({required this.getMenu, required String restaurantId})
      : super(MenuCartState.initial(restaurantId));

  Future<void> loadMenu() async {
    emit(state.copyWith(status: MenuCartStatus.loading, failure: null));
    final result = await getMenu(state.restaurantId);
    if (result is Success<List<MenuItem>>) {
      emit(state.copyWith(status: MenuCartStatus.loaded, menu: result.data));
    } else if (result is Error<List<MenuItem>>) {
      emit(state.copyWith(status: MenuCartStatus.failure, failure: result.failure));
    }
  }

  Future<void> loadMenuForRestaurant(String restaurantId) async {
    emit(state.copyWith(restaurantId: restaurantId, status: MenuCartStatus.loading, failure: null));
    final result = await getMenu(restaurantId);
    if (result is Success<List<MenuItem>>) {
      emit(state.copyWith(status: MenuCartStatus.loaded, menu: result.data));
    } else if (result is Error<List<MenuItem>>) {
      emit(state.copyWith(status: MenuCartStatus.failure, failure: result.failure));
    }
  }

  void addItem(MenuItem item) {
    final items = List<CartItem>.from(state.cart.items);
    final index = items.indexWhere((e) => e.item.id == item.id);
    if (index >= 0) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    } else {
      items.add(CartItem(item: item, quantity: 1));
    }
    emit(state.copyWith(cart: Cart(restaurantId: state.restaurantId, items: items)));
  }

  void removeItem(MenuItem item) {
    final items = List<CartItem>.from(state.cart.items);
    final index = items.indexWhere((e) => e.item.id == item.id);
    if (index >= 0) {
      final q = items[index].quantity - 1;
      if (q <= 0) {
        items.removeAt(index);
      } else {
        items[index] = items[index].copyWith(quantity: q);
      }
      emit(state.copyWith(cart: Cart(restaurantId: state.restaurantId, items: items)));
    }
  }
}
