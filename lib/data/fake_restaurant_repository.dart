import 'dart:async';
import 'dart:math';

import '../core/failure.dart';
import '../domain/models/menu_item.dart';
import '../domain/models/restaurant.dart';
import '../domain/repositories/restaurant_repository.dart';

class FakeRestaurantRepository implements RestaurantRepository {
  final Random _rng;
  FakeRestaurantRepository({Random? rng}) : _rng = rng ?? Random();

  @override
  Future<Result<List<Restaurant>>> getNearbyRestaurants() async {
    await Future.delayed(const Duration(milliseconds: 900));
    // 20% chance of failure
    if (_rng.nextDouble() < 0.2) {
      return Error(Failure('Failed to load restaurants', code: 'network'));
    }
    final list = [
      const Restaurant(
        id: 'r1',
        name: 'Spice Garden',
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600&h=400&fit=crop',
        rating: 4.5,
        distanceText: '0.8 km',
      ),
      const Restaurant(
        id: 'r2',
        name: 'Pasta Palace',
        imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=600&h=400&fit=crop',
        rating: 4.3,
        distanceText: '1.2 km',
      ),
      const Restaurant(
        id: 'r3',
        name: 'Sushi Central',
        imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=600&h=400&fit=crop',
        rating: 4.7,
        distanceText: '2.3 km',
      ),
    ];
    return Success(list);
  }

  @override
  Future<Result<List<MenuItem>>> getMenu(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (_rng.nextDouble() < 0.15) {
      return Error(Failure('Unable to fetch menu', code: 'network'));
    }
    final items = <MenuItem>[
      MenuItem(
        id: '${restaurantId}_m1',
        restaurantId: restaurantId,
        name: 'Classic Cheeseburger',
        description: 'Juicy beef patty with cheese, lettuce, and tomato on a sesame bun.',
        price: 12.99,
        category: 'Burger',
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&h=300&fit=crop',
      ),
      MenuItem(
        id: '${restaurantId}_m2',
        restaurantId: restaurantId,
        name: 'Grilled Ribeye Steak',
        description: 'Premium ribeye steak grilled to perfection with herbs.',
        price: 24.99,
        category: 'Steak',
        imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400',
      ),
      MenuItem(
        id: '${restaurantId}_m3',
        restaurantId: restaurantId,
        name: 'Grilled Salmon',
        description: 'Fresh Atlantic salmon with lemon and herbs.',
        price: 18.99,
        category: 'Sea Food',
        imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400',
      ),
      MenuItem(
        id: '${restaurantId}_m4',
        restaurantId: restaurantId,
        name: 'Margherita Pizza',
        description: 'Classic pizza with fresh basil, mozzarella, and tomato sauce.',
        price: 14.99,
        category: 'Pizza',
        imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400&h=300&fit=crop',
      ),
      MenuItem(
        id: '${restaurantId}_m5',
        restaurantId: restaurantId,
        name: 'Chocolate Lava Cake',
        description: 'Warm chocolate cake with molten center and vanilla ice cream.',
        price: 8.99,
        category: 'Desserts',
        imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400',
      ),
      MenuItem(
        id: '${restaurantId}_m6',
        restaurantId: restaurantId,
        name: 'BBQ Bacon Burger',
        description: 'Smoky BBQ burger with crispy bacon and onion rings.',
        price: 15.99,
        category: 'Burger',
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
      ),
    ];
    return Success(items);
  }

  @override
  Future<Result<List<MenuItem>>> getItemsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_rng.nextDouble() < 0.1) {
      return Error(Failure('Unable to fetch items', code: 'network'));
    }
    
    // All available items across restaurants
    final allItems = <MenuItem>[
      const MenuItem(
        id: 'burger_1',
        restaurantId: 'r1',
        name: 'Classic Cheeseburger',
        description: 'Juicy beef patty with cheese, lettuce, and tomato on a sesame bun.',
        price: 12.99,
        category: 'Burger',
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&h=300&fit=crop',
      ),
      const MenuItem(
        id: 'burger_2',
        restaurantId: 'r2',
        name: 'BBQ Bacon Burger',
        description: 'Smoky BBQ burger with crispy bacon and onion rings.',
        price: 15.99,
        category: 'Burger',
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
      ),
      const MenuItem(
        id: 'burger_3',
        restaurantId: 'r3',
        name: 'Mushroom Swiss Burger',
        description: 'Grilled mushrooms and Swiss cheese on a beef patty.',
        price: 14.49,
        category: 'Burger',
        imageUrl: 'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=400',
      ),
      const MenuItem(
        id: 'steak_1',
        restaurantId: 'r1',
        name: 'Grilled Ribeye Steak',
        description: 'Premium ribeye steak grilled to perfection with herbs.',
        price: 24.99,
        category: 'Steak',
        imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400',
      ),
      const MenuItem(
        id: 'steak_2',
        restaurantId: 'r2',
        name: 'Filet Mignon',
        description: 'Tender filet mignon with garlic butter.',
        price: 28.99,
        category: 'Steak',
        imageUrl: 'https://images.unsplash.com/photo-1558030006-450675393462?w=400',
      ),
      const MenuItem(
        id: 'seafood_1',
        restaurantId: 'r1',
        name: 'Grilled Salmon',
        description: 'Fresh Atlantic salmon with lemon and herbs.',
        price: 18.99,
        category: 'Sea Food',
        imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400',
      ),
      const MenuItem(
        id: 'seafood_2',
        restaurantId: 'r3',
        name: 'Lobster Tail',
        description: 'Butter-poached lobster tail with garlic.',
        price: 32.99,
        category: 'Sea Food',
        imageUrl: 'https://images.unsplash.com/photo-1559737558-2f5a35f4523b?w=400',
      ),
      const MenuItem(
        id: 'pizza_1',
        restaurantId: 'r2',
        name: 'Margherita Pizza',
        description: 'Classic pizza with fresh basil, mozzarella, and tomato sauce.',
        price: 14.99,
        category: 'Pizza',
        imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400&h=300&fit=crop',
      ),
      const MenuItem(
        id: 'pizza_2',
        restaurantId: 'r1',
        name: 'Pepperoni Pizza',
        description: 'Traditional pepperoni pizza with mozzarella cheese.',
        price: 16.99,
        category: 'Pizza',
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
      ),
      const MenuItem(
        id: 'dessert_1',
        restaurantId: 'r1',
        name: 'Chocolate Lava Cake',
        description: 'Warm chocolate cake with molten center and vanilla ice cream.',
        price: 8.99,
        category: 'Desserts',
        imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400',
      ),
      const MenuItem(
        id: 'dessert_2',
        restaurantId: 'r2',
        name: 'Tiramisu',
        description: 'Classic Italian dessert with coffee and mascarpone.',
        price: 7.99,
        category: 'Desserts',
        imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400',
      ),
    ];
    
    final filteredItems = allItems.where((item) => item.category == category).toList();
    return Success(filteredItems);
  }
}
