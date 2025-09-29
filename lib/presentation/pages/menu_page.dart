import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/menu_cart/menu_cart_cubit.dart';
import '../../domain/models/menu_item.dart';
import '../../domain/models/restaurant.dart';
import 'cart_checkout_page.dart';
import '../theme/vibrant_bites_theme.dart';
import '../widgets/add_ons_list.dart';
import '../widgets/quantity_stepper_vibrant.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    // Load menu data when page is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null && arguments is Restaurant) {
        context.read<MenuCartCubit>().loadMenuForRestaurant(arguments.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments == null || arguments is! Restaurant) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error', style: VibrantBites.headingLight),
          backgroundColor: VibrantBites.darkGrey,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: VibrantBites.mediumGrey,
              ),
              const SizedBox(height: 16),
              Text('Restaurant data not found', style: VibrantBites.bodyLarge),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final Restaurant restaurant = arguments;

    // Load menu for this restaurant using the global MenuCartCubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuCartCubit>().loadMenuForRestaurant(restaurant.id);
    });

    return _MenuView(restaurant: restaurant);
  }
}

class _MenuView extends StatelessWidget {
  final Restaurant restaurant;
  const _MenuView({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocBuilder<MenuCartCubit, MenuCartState>(
        builder: (context, state) {
          switch (state.status) {
            case MenuCartStatus.initial:
            case MenuCartStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case MenuCartStatus.failure:
              return _ErrorView(
                message: state.failure?.message ?? 'Failed to load menu',
                onRetry: () => context.read<MenuCartCubit>().loadMenu(),
              );
            case MenuCartStatus.loaded:
              return _buildMenuContent(
                context,
                state.menu.first,
              ); // Show first item as detail
          }
        },
      ),
    );
  }

  Widget _buildMenuContent(BuildContext context, MenuItem item) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(context, item),
          _buildContentCard(context, item),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, MenuItem item) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800', // Burger image
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: VibrantBites.charcoal.withOpacity(0.8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: VibrantBites.white,
                  size: 20,
                ),
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: VibrantBites.charcoal.withOpacity(0.8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.share,
                    color: VibrantBites.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: VibrantBites.smallSpacing),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: VibrantBites.charcoal.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(
                      VibrantBites.overlayButtonRadius,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Help',
                    style: VibrantBites.bodyLight.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard(BuildContext context, MenuItem item) {
    return Transform.translate(
      offset: const Offset(0, -40), // More pronounced overlap
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: VibrantBites.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25.0), // More pronounced border radius
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 24,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(VibrantBites.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: VibrantBites.smallSpacing),
              Text(
                'Superiority Burger - Houston',
                style: VibrantBites.headingExtraBold, // H1 - Main titles (28px)
              ),
              const SizedBox(height: VibrantBites.smallSpacing),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: VibrantBites.warmYellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(
                    VibrantBites.overlayButtonRadius,
                  ),
                  border: Border.all(
                    color: VibrantBites.warmYellow.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  '#1 Most liked',
                  style: VibrantBites.bodySmall.copyWith(
                    color: VibrantBites.charcoal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: VibrantBites.elementSpacing),
              Row(
                children: [
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style:
                        VibrantBites.priceText, // Prominent price text (32px)
                  ),
                  const Spacer(),
                  Text('200 Cal.', style: VibrantBites.bodySecondaryDark),
                  const SizedBox(width: VibrantBites.elementSpacing),
                  Text('Origin: US', style: VibrantBites.bodySecondaryDark),
                ],
              ),
              const SizedBox(height: VibrantBites.elementSpacing),
              Text(
                item.description,
                style: VibrantBites.bodyLarge, // 16px body text
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),
              AddOnsList(
                addOns: [
                  AddOnItem(name: 'Mushroom', price: 2.50),
                  AddOnItem(name: 'Chicken Patty', price: 4.00),
                  AddOnItem(name: 'Extra Cheese', price: 1.50),
                ],
              ),
              const SizedBox(height: 32),
              _buildBottomSection(context, item),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, MenuItem item) {
    return BlocBuilder<MenuCartCubit, MenuCartState>(
      builder: (context, state) {
        final cubit = context.read<MenuCartCubit>();
        int qty = 0;
        for (final ci in state.cart.items) {
          if (ci.item.id == item.id) {
            qty = ci.quantity;
            break;
          }
        }

        return Row(
          children: [
            QuantityStepperVibrant(
              quantity: qty,
              onAddFromZero: () => cubit.addItem(item),
              onAdd: () => cubit.addItem(item),
              onRemove: () => cubit.removeItem(item),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  if (qty == 0) cubit.addItem(item);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: cubit,
                        child: const CartCheckoutPage(),
                      ),
                      settings: RouteSettings(
                        name: '/checkout',
                        arguments: restaurant,
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: VibrantBites.boldOrangeRed,
                  foregroundColor: VibrantBites.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      VibrantBites.buttonBorderRadius,
                    ),
                  ),
                ),
                child: Text(
                  'Add to cart', // Fixed typo from "Add to card"
                  style: VibrantBites.buttonText,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
