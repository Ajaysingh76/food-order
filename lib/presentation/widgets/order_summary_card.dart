import 'package:flutter/material.dart';
import '../theme/urban_harvest_theme.dart';

class OrderSummaryCard extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  const OrderSummaryCard({super.key, required this.subtotal, required this.deliveryFee});

  double get total => subtotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Order Summary', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _row('Subtotal', subtotal),
            const SizedBox(height: 6),
            _row('Delivery Fee', deliveryFee),
            const Divider(height: 24),
            _row('Total', total, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, double amount, {bool isTotal = false}) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: isTotal
              ? const TextStyle(fontWeight: FontWeight.w700, color: UrbanHarvest.forestGreen)
              : const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
