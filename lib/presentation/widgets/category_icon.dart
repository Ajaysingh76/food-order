import 'package:flutter/material.dart';
import '../theme/vibrant_bites_theme.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  
  const CategoryIcon({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isSelected ? VibrantBites.boldOrangeRed : VibrantBites.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: isSelected ? VibrantBites.white : VibrantBites.charcoal,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: VibrantBites.bodyDark.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? VibrantBites.boldOrangeRed : VibrantBites.charcoal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
