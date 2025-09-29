import 'package:flutter/material.dart';
import '../theme/urban_harvest_theme.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelected;
  const CategoryChips({super.key, required this.categories, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: UrbanHarvest.screenPadding),
        itemBuilder: (_, i) {
          final cat = categories[i];
          final isSelected = cat == selected;
          return ChoiceChip(
            selected: isSelected,
            label: Text(cat, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: UrbanHarvest.charcoal)),
            selectedColor: UrbanHarvest.goldenrod,
            backgroundColor: const Color(0xFFE0E0E0),
            onSelected: (_) => onSelected(cat),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}
