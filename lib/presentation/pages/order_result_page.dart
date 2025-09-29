import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/order/order_bloc.dart';
import '../theme/vibrant_bites_theme.dart';

class OrderResultPage extends StatelessWidget {
  const OrderResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VibrantBites.creamyOffWhite,
      appBar: AppBar(
        title: Text(
          'Order Status',
          style: VibrantBites.headingLight.copyWith(fontSize: 18),
        ),
        backgroundColor: VibrantBites.darkGrey,
        foregroundColor: VibrantBites.white,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          switch (state.status) {
            case OrderStatus.initial:
            case OrderStatus.processing:
              return const _Processing();
            case OrderStatus.success:
              return _Success(
                orderId: state.order!.id,
                amount: state.order!.total,
              );
            case OrderStatus.failure:
              return _Failure(
                message: state.failure?.message ?? 'Payment failed',
                onRetry: () {
                  context.read<OrderBloc>().add(const OrderRetry());
                  Navigator.of(context).pop();
                },
              );
          }
        },
      ),
    );
  }
}

class _Processing extends StatelessWidget {
  const _Processing();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              valueColor: AlwaysStoppedAnimation<Color>(
                VibrantBites.boldOrangeRed,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Processing order...',
            style: VibrantBites.headingBold.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we prepare your meal',
            style: VibrantBites.bodySecondaryDark,
          ),
        ],
      ),
    );
  }
}

class _Success extends StatelessWidget {
  final String orderId;
  final double amount;
  const _Success({required this.orderId, required this.amount});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(VibrantBites.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    Text(
                      'Order Confirmed!',
                      style: VibrantBites.headingBold.copyWith(
                        fontSize: 28,
                        color: VibrantBites.boldOrangeRed,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your delicious meal is on its way',
                      style: VibrantBites.bodySecondaryDark.copyWith(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    // Order ID
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: VibrantBites.boldOrangeRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Order ID: $orderId',
                        style: VibrantBites.headingBold.copyWith(
                          fontSize: 16,
                          color: VibrantBites.boldOrangeRed,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Order Summary
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: VibrantBites.white,
                        borderRadius: BorderRadius.circular(
                          VibrantBites.cardBorderRadius,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary',
                            style: VibrantBites.headingBold.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Total Amount',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Text(
                                '\$${amount.toStringAsFixed(2)}',
                                style: VibrantBites.headingBold.copyWith(
                                  fontSize: 18,
                                  color: VibrantBites.boldOrangeRed,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: VibrantBites.boldOrangeRed,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Estimated delivery: 25-30 mins',
                                style: VibrantBites.bodyDark.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
              style: FilledButton.styleFrom(
                backgroundColor: VibrantBites.boldOrangeRed,
                foregroundColor: VibrantBites.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    VibrantBites.buttonBorderRadius,
                  ),
                ),
              ),
              child: Text(
                'Back to Home',
                style: VibrantBites.headingLight.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Failure extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _Failure({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(VibrantBites.screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 60,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Payment Failed',
              style: VibrantBites.headingBold.copyWith(
                fontSize: 24,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: VibrantBites.bodySecondaryDark.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: FilledButton.styleFrom(
                backgroundColor: VibrantBites.boldOrangeRed,
                foregroundColor: VibrantBites.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    VibrantBites.buttonBorderRadius,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
