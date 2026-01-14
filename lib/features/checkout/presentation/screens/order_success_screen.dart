import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/widgets/primary_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green[50],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green,
              ),
            ).animate().scale(duration: 500.ms).then().shake(),
            const SizedBox(height: 32),
            Text(
              'Order Placed!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ).animate().fadeIn().moveY(begin: 20, end: 0),
            const SizedBox(height: 16),
            const Text(
              'Your order #30492 has been placed successfully. We will email you the tracking details.',
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 48),
            PrimaryButton(
              text: 'Continue Shopping',
              onPressed: () => context.go('/home'),
            ).animate().fadeIn(delay: 400.ms),
          ],
        ),
      ),
    );
  }
}
