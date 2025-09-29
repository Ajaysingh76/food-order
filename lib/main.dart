import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/category/category_bloc.dart';
import 'application/menu_cart/menu_cart_cubit.dart';
import 'application/order/order_bloc.dart';
import 'application/restaurant_list/restaurant_list_bloc.dart';
import 'di/locator.dart';
import 'domain/usecases/get_menu.dart';
import 'domain/usecases/get_restaurants.dart';
import 'domain/use_cases/get_items_by_category.dart';
import 'domain/usecases/place_order.dart';
import 'presentation/pages/cart_checkout_page.dart';
import 'presentation/pages/category_page.dart';
import 'presentation/pages/item_details_page.dart';
import 'presentation/pages/menu_page.dart';
import 'presentation/pages/order_result_page.dart';
import 'presentation/pages/restaurant_list_page.dart';
import 'presentation/theme/vibrant_bites_theme.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              RestaurantListBloc(getRestaurants: sl<GetRestaurants>()),
        ),
        BlocProvider(
          create: (_) =>
              CategoryBloc(getItemsByCategory: sl<GetItemsByCategory>()),
        ),
        BlocProvider(
          create: (_) =>
              MenuCartCubit(getMenu: sl<GetMenu>(), restaurantId: ''),
        ),
        BlocProvider(create: (_) => OrderBloc(placeOrder: sl<PlaceOrder>())),
      ],
      child: MaterialApp(
        title: 'Foodie Flow',
        theme: VibrantBites.theme(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const RestaurantListPage(),
          '/menu': (context) => const MenuPage(),
          '/category': (context) => const CategoryPage(),
          '/item_details': (context) => const ItemDetailsPage(),
          '/checkout': (context) => const CartCheckoutPage(),
          '/order_result': (context) => const OrderResultPage(),
        },
      ),
    );
  }
}
