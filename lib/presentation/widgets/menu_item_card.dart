import 'package:flutter/material.dart';
import '../../domain/models/menu_item.dart';
import '../theme/vibrant_bites_theme.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback? onTap;
  final bool showCategoryTag;
  
  const MenuItemCard({
    super.key,
    required this.item,
    this.onTap,
    this.showCategoryTag = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // Item Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(VibrantBites.cardBorderRadius),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: VibrantBites.mediumGrey.withOpacity(0.2),
                      child: Icon(
                        Icons.restaurant,
                        size: 48,
                        color: VibrantBites.mediumGrey,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Item Details
            Padding(
              padding: const EdgeInsets.all(VibrantBites.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: VibrantBites.headingSemiBold, // H3 - Card titles (18px)
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: VibrantBites.bodyMedium, // 14px body text
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: VibrantBites.smallSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: VibrantBites.headingMedium.copyWith(
                          color: VibrantBites.boldOrangeRed,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (showCategoryTag)
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
