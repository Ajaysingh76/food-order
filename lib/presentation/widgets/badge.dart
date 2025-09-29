import 'package:flutter/material.dart';
import '../theme/urban_harvest_theme.dart';

class UhBadge extends StatelessWidget {
  final String label;
  const UhBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: UrbanHarvest.goldenrod,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: UrbanHarvest.charcoal, fontWeight: FontWeight.w700),
      ),
    );
  }
}
