import 'package:flutter/material.dart';
import '../../domain/models/restaurant.dart';
import '../theme/vibrant_bites_theme.dart';

class RestaurantCardVibrant extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback? onTap;
  
  const RestaurantCardVibrant({
    super.key,
    required this.restaurant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = restaurant.rating >= 4.5;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(VibrantBites.cardBorderRadius),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image.network(
                      restaurant.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                if (hasDiscount)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: VibrantBites.boldOrangeRed,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '15% off: NEW15',
                        style: VibrantBites.bodyLight.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: VibrantBites.boldOrangeRed,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: VibrantBites.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(VibrantBites.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: VibrantBites.headingSemiBold, // H3 - Card titles (18px)
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$\$ • Italian, Pizza',
                    style: VibrantBites.bodyMedium, // 14px body text
                  ),
                  const SizedBox(height: VibrantBites.smallSpacing),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: VibrantBites.warmYellow, // Ensuring warm yellow star
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.rating.toStringAsFixed(1),
                        style: VibrantBites.headingMedium.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '• 25-30 min',
                        style: VibrantBites.bodySecondaryDark,
                      ),
                      const Spacer(),
                      Text(
                        'Free delivery',
                        style: VibrantBites.bodySmall.copyWith(
                          color: VibrantBites.boldOrangeRed,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
