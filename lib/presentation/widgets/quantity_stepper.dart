import 'package:flutter/material.dart';
import '../theme/urban_harvest_theme.dart';

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onAddFromZero;
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onAddFromZero,
  });

  @override
  Widget build(BuildContext context) {
    if (quantity <= 0) {
      return OutlinedButton(
        onPressed: onAddFromZero,
        child: const Text('ADD'),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: UrbanHarvest.forestGreen),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.remove, color: UrbanHarvest.forestGreen),
            visualDensity: VisualDensity.compact,
          ),
          Text(
            quantity.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: UrbanHarvest.charcoal),
          ),
          IconButton(
            onPressed: onAdd,
            icon: const Icon(Icons.add, color: UrbanHarvest.forestGreen),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
