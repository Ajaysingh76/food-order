import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/menu_cart/menu_cart_cubit.dart';
import '../../domain/models/cart.dart';
import '../../domain/models/menu_item.dart';
import '../theme/vibrant_bites_theme.dart';
import '../widgets/add_ons_list.dart';
import '../widgets/quantity_stepper_vibrant.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    
    if (arguments == null || arguments is! MenuItem) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error', style: VibrantBites.headingLight),
          backgroundColor: VibrantBites.darkGrey,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: VibrantBites.mediumGrey),
              const SizedBox(height: 16),
              Text('Item details not found', style: VibrantBites.bodyLarge),
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
    
    final MenuItem item = arguments;
    return _ItemDetailsView(item: item);
  }
}

class _ItemDetailsView extends StatefulWidget {
  final MenuItem item;
  const _ItemDetailsView({required this.item});

  @override
  State<_ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<_ItemDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Hero Image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: VibrantBites.mediumGrey.withOpacity(0.2),
                        child: Icon(
                          Icons.restaurant,
                          size: 64,
                          color: VibrantBites.mediumGrey,
                        ),
                      );
                    },
                  ),
                ),
                // Back button
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
                      icon: const Icon(Icons.arrow_back, color: VibrantBites.white, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content Card
          _buildContentCard(context, widget.item),
        ],
      ),
    );
  }

  Widget _buildContentCard(BuildContext context, MenuItem item) {
    return Transform.translate(
      offset: const Offset(0, -40),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
        decoration: BoxDecoration(
          color: VibrantBites.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 24,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(VibrantBites.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: VibrantBites.smallSpacing),
              Text(
                item.name,
                style: VibrantBites.headingExtraBold,
              ),
              const SizedBox(height: VibrantBites.smallSpacing),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: VibrantBites.boldOrangeRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(VibrantBites.overlayButtonRadius),
                  border: Border.all(
                    color: VibrantBites.boldOrangeRed.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  item.category,
                  style: VibrantBites.bodySmall.copyWith(
                    color: VibrantBites.boldOrangeRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: VibrantBites.elementSpacing),
              Row(
                children: [
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: VibrantBites.priceText,
                  ),
                  const Spacer(),
                  Text(
                    '200 Cal.',
                    style: VibrantBites.bodySecondaryDark,
                  ),
                ],
              ),
              const SizedBox(height: VibrantBites.elementSpacing),
              Text(
                item.description,
                style: VibrantBites.bodyLarge,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),
              AddOnsList(
                addOns: [
                  AddOnItem(name: 'Extra Cheese', price: 1.50),
                  AddOnItem(name: 'Bacon', price: 2.00),
                  AddOnItem(name: 'Avocado', price: 1.75),
                ],
              ),
              const SizedBox(height: 32),
              BlocBuilder<MenuCartCubit, MenuCartState>(
                builder: (context, state) {
                  final cartItem = state.cart.items.firstWhere(
                    (ci) => ci.item.id == item.id,
                    orElse: () => CartItem(item: item, quantity: 0),
                  );
                  
                  return Row(
                    children: [
                      QuantityStepperVibrant(
                        quantity: cartItem.quantity,
                        onAddFromZero: () => context.read<MenuCartCubit>().addItem(item),
                        onAdd: () => context.read<MenuCartCubit>().addItem(item),
                        onRemove: () => context.read<MenuCartCubit>().removeItem(item),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            context.read<MenuCartCubit>().addItem(item);
                            
                            // Show feedback SnackBar with mounted check
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${item.name} added to cart'),
                                  backgroundColor: VibrantBites.boldOrangeRed,
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            }
                            
                            Navigator.of(context).pushNamed('/checkout');
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: VibrantBites.boldOrangeRed,
                            foregroundColor: VibrantBites.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(VibrantBites.buttonBorderRadius),
                            ),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: VibrantBites.buttonText,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
