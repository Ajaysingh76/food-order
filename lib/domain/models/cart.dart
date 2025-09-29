import 'package:equatable/equatable.dart';
import 'menu_item.dart';

class CartItem extends Equatable {
  final MenuItem item;
  final int quantity;

  const CartItem({required this.item, required this.quantity});

  CartItem copyWith({MenuItem? item, int? quantity}) =>
      CartItem(item: item ?? this.item, quantity: quantity ?? this.quantity);

  double get subtotal => item.price * quantity;

  @override
  List<Object?> get props => [item, quantity];
}

class Cart extends Equatable {
  final String restaurantId;
  final List<CartItem> items;

  const Cart({required this.restaurantId, required this.items});

  double get total => items.fold(0.0, (p, e) => p + e.subtotal);

  bool get isEmpty => items.isEmpty;

  @override
  List<Object?> get props => [restaurantId, items];
}
