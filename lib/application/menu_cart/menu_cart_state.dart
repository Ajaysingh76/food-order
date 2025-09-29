part of 'menu_cart_cubit.dart';

enum MenuCartStatus { initial, loading, loaded, failure }

class MenuCartState extends Equatable {
  final String restaurantId;
  final MenuCartStatus status;
  final List<MenuItem> menu;
  final Cart cart;
  final Failure? failure;

  const MenuCartState({
    required this.restaurantId,
    required this.status,
    required this.menu,
    required this.cart,
    required this.failure,
  });

  factory MenuCartState.initial(String restaurantId) => MenuCartState(
        restaurantId: restaurantId,
        status: MenuCartStatus.initial,
        menu: const [],
        cart: Cart(restaurantId: restaurantId, items: const []),
        failure: null,
      );

  MenuCartState copyWith({
    String? restaurantId,
    MenuCartStatus? status,
    List<MenuItem>? menu,
    Cart? cart,
    Failure? failure,
  }) {
    return MenuCartState(
      restaurantId: restaurantId ?? this.restaurantId,
      status: status ?? this.status,
      menu: menu ?? this.menu,
      cart: cart ?? this.cart,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [restaurantId, status, menu, cart, failure];
}
