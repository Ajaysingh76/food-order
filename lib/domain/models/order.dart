import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String restaurantId;
  final double total;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.restaurantId,
    required this.total,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, restaurantId, total, createdAt];
}
