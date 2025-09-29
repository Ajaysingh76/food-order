import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_flow/application/order/order_bloc.dart';

import '../../application/menu_cart/menu_cart_cubit.dart';
// ADD THIS IMPORT
import '../../domain/models/cart.dart';
import '../theme/vibrant_bites_theme.dart';
import '../widgets/quantity_stepper_vibrant.dart';

class CartCheckoutPage extends StatelessWidget {
  const CartCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart', style: VibrantBites.headingLight),
        backgroundColor: VibrantBites.darkGrey,
        foregroundColor: VibrantBites.white,
        elevation: 0,
      ),
      body: BlocBuilder<MenuCartCubit, MenuCartState>(
        builder: (context, state) {
          if (state.cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: VibrantBites.mediumGrey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: VibrantBites.headingBold.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add some delicious items to get started',
                    style: VibrantBites.bodySecondaryDark,
                  ),
                ],
              ),
            );
          }
          final deliveryFee = state.cart.total > 0 ? 2.50 : 0.0;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                ...state.cart.items
                    .map((ci) => _buildCartItem(context, ci))
                    .toList(),
                const SizedBox(height: 24),
                _buildOrderSummary(state.cart.total, deliveryFee),
                const SizedBox(height: 100), // Space for bottom button
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<MenuCartCubit, MenuCartState>(
        builder: (context, state) {
          final total = state.cart.total + (state.cart.total > 0 ? 2.50 : 0.0);
          return SafeArea(
            minimum: const EdgeInsets.all(VibrantBites.screenPadding),
            child: FilledButton(
              onPressed: state.cart.items.isEmpty
                  ? null
                  : () {
                      final total =
                          state.cart.total +
                          (state.cart.total > 0 ? 2.50 : 0.0);

                      final orderBloc = context.read<OrderBloc>();
                      orderBloc.add(OrderPlaced(amount: total));

                      Navigator.of(
                        context,
                      ).pushReplacementNamed('/order_result');
                    },

              style: FilledButton.styleFrom(
                backgroundColor: VibrantBites.boldOrangeRed,
                foregroundColor: VibrantBites.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    VibrantBites.buttonBorderRadius,
                  ),
                ),
              ),
              child: Text(
                'Checkout · \$${total.toStringAsFixed(2)}',
                style: VibrantBites.buttonText.copyWith(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }

  // FIX: Changed 'dynamic' to 'CartItem' for type safety
  Widget _buildCartItem(BuildContext context, CartItem cartItem) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: VibrantBites.screenPadding,
        vertical: VibrantBites.smallSpacing / 2,
      ),
      padding: const EdgeInsets.all(VibrantBites.cardPadding),
      decoration: BoxDecoration(
        color: VibrantBites.white,
        borderRadius: BorderRadius.circular(VibrantBites.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              VibrantBites.overlayButtonRadius,
            ),
            child: SizedBox(
              width: 64,
              height: 64,
              // FIX: Replaced hardcoded URL with dynamic item image URL
              child: Image.network(
                cartItem.item.imageUrl,
                fit: BoxFit.cover,
                // Optional: Add error and loading builders for a better UX
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : const Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.fastfood_outlined),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.item.name,
                  style: VibrantBites.headingMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${cartItem.item.price.toStringAsFixed(2)}',
                  style: VibrantBites.bodyMedium.copyWith(
                    color: VibrantBites.boldOrangeRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          QuantityStepperVibrant(
            quantity: cartItem.quantity,
            onAddFromZero: () =>
                context.read<MenuCartCubit>().addItem(cartItem.item),
            onAdd: () => context.read<MenuCartCubit>().addItem(cartItem.item),
            onRemove: () =>
                context.read<MenuCartCubit>().removeItem(cartItem.item),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(double subtotal, double deliveryFee) {
    final total = subtotal + deliveryFee;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: VibrantBites.screenPadding,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: VibrantBites.white,
        borderRadius: BorderRadius.circular(VibrantBites.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: VibrantBites.headingSemiBold, // H3 - Card titles (18px)
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Subtotal', subtotal),
          const SizedBox(height: 8),
          _buildSummaryRow('Delivery Fee', deliveryFee),
          const Divider(height: 24),
          _buildSummaryRow('Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: isTotal
                ? VibrantBites
                      .headingMedium // H4 - Small headings (16px)
                : VibrantBites.bodyLarge, // 16px body text
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: isTotal
              ? VibrantBites.headingMedium.copyWith(
                  color: VibrantBites.boldOrangeRed,
                  fontWeight: FontWeight.w700,
                )
              : VibrantBites.bodyLarge,
        ),
      ],
    );
  }
}
