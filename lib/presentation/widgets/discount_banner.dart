import 'package:flutter/material.dart';
import '../theme/vibrant_bites_theme.dart';

class DiscountBanner extends StatelessWidget {
  final String mainText;
  final String subText;
  
  const DiscountBanner({
    super.key,
    this.mainText = '15% EXTRA DISCOUNT',
    this.subText = 'Get your first order delivery free!',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: VibrantBites.screenPadding),
      padding: const EdgeInsets.all(VibrantBites.cardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            VibrantBites.darkGrey,
            VibrantBites.jetBlack.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(VibrantBites.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center align text
              children: [
                Text(
                  mainText,
                  style: VibrantBites.headingSemiBold.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: VibrantBites.boldOrangeRed,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  subText,
                  style: VibrantBites.bodyLight.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(width: VibrantBites.elementSpacing),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: VibrantBites.boldOrangeRed,
              borderRadius: BorderRadius.circular(VibrantBites.overlayButtonRadius),
              boxShadow: [
                BoxShadow(
                  color: VibrantBites.boldOrangeRed.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.local_offer,
              color: VibrantBites.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
