import 'package:flutter/material.dart';

class PromoCodeField extends StatefulWidget {
  final void Function(String code)? onApply;
  const PromoCodeField({super.key, this.onApply});

  @override
  State<PromoCodeField> createState() => _PromoCodeFieldState();
}

class _PromoCodeFieldState extends State<PromoCodeField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Promo Code',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () => widget.onApply?.call(_controller.text.trim()),
          child: const Text('Apply'),
        )
      ],
    );
  }
}
