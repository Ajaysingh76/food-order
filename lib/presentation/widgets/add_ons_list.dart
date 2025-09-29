import 'package:flutter/material.dart';
import '../theme/vibrant_bites_theme.dart';

class AddOnItem {
  final String name;
  final double price;
  final bool isSelected;
  
  AddOnItem({
    required this.name,
    required this.price,
    this.isSelected = false,
  });
}

class AddOnsList extends StatefulWidget {
  final List<AddOnItem> addOns;
  final ValueChanged<List<AddOnItem>>? onChanged;
  
  const AddOnsList({
    super.key,
    required this.addOns,
    this.onChanged,
  });

  @override
  State<AddOnsList> createState() => _AddOnsListState();
}

class _AddOnsListState extends State<AddOnsList> {
  late List<AddOnItem> _addOns;

  @override
  void initState() {
    super.initState();
    _addOns = List.from(widget.addOns);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Add ons for Burger',
              style: VibrantBites.headingBold.copyWith(fontSize: 18),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: VibrantBites.lightGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Optional',
                style: VibrantBites.bodySecondaryDark.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._addOns.asMap().entries.map((entry) {
          final index = entry.key;
          final addOn = entry.value;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Checkbox(
                  value: addOn.isSelected,
                  onChanged: (value) {
                    setState(() {
                      _addOns[index] = AddOnItem(
                        name: addOn.name,
                        price: addOn.price,
                        isSelected: value ?? false,
                      );
                    });
                    widget.onChanged?.call(_addOns);
                  },
                  activeColor: VibrantBites.boldOrangeRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    addOn.name,
                    style: VibrantBites.bodyDark.copyWith(fontSize: 16),
                  ),
                ),
                Text(
                  '+\$${addOn.price.toStringAsFixed(2)}',
                  style: VibrantBites.bodyDark.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: VibrantBites.boldOrangeRed,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
