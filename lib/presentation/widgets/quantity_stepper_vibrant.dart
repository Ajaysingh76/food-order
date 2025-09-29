import 'package:flutter/material.dart';
import '../theme/vibrant_bites_theme.dart';

class QuantityStepperVibrant extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onAddFromZero;
  
  const QuantityStepperVibrant({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onAddFromZero,
  });

  @override
  Widget build(BuildContext context) {
    if (quantity <= 0) {
      return FilledButton(
        onPressed: onAddFromZero,
        style: FilledButton.styleFrom(
          backgroundColor: VibrantBites.boldOrangeRed,
          foregroundColor: VibrantBites.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(VibrantBites.buttonBorderRadius),
          ),
        ),
        child: const Text('ADD'),
      );
    }
    
    return Container(
      decoration: BoxDecoration(
        color: VibrantBites.white,
        borderRadius: BorderRadius.circular(VibrantBites.buttonBorderRadius),
        border: Border.all(color: VibrantBites.boldOrangeRed, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepperButton(
            icon: Icons.remove,
            onPressed: onRemove,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              quantity.toString(),
              style: VibrantBites.headingBold.copyWith(
                fontSize: 16,
                color: VibrantBites.boldOrangeRed,
              ),
            ),
          ),
          _buildStepperButton(
            icon: Icons.add,
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }

  Widget _buildStepperButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: VibrantBites.boldOrangeRed,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: VibrantBites.white,
          size: 20,
        ),
      ),
    );
  }
}
