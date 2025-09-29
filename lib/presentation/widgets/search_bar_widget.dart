import 'package:flutter/material.dart';
import '../theme/vibrant_bites_theme.dart';

class SearchBarWidget extends StatelessWidget {
  final String placeholder;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onChanged;
  const SearchBarWidget({
    super.key,
    this.placeholder = 'Search by name & restaurant',
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: VibrantBites.screenPadding),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56.0, // Comfortable height
              decoration: BoxDecoration(
                color: VibrantBites.white,
                borderRadius: BorderRadius.circular(VibrantBites.searchBarBorderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                style: VibrantBites.bodyMedium,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Search for restaurants, food...',
                  hintStyle: VibrantBites.bodySecondaryDark,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: VibrantBites.mediumGrey,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: VibrantBites.smallSpacing),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: VibrantBites.boldOrangeRed,
                borderRadius: BorderRadius.circular(VibrantBites.searchBarBorderRadius),
                boxShadow: [
                  BoxShadow(
                    color: VibrantBites.boldOrangeRed.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.tune,
                color: VibrantBites.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
