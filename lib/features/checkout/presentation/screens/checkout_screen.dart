import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/primary_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPayment = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Shipping Address'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('123 Flutter St, Dart City, USA 10010'),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Change')),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('Payment Method'),
            const SizedBox(height: 16),
            _buildPaymentOption(0, 'Credit Card', Icons.credit_card),
            _buildPaymentOption(1, 'PayPal', Icons.payment),
            _buildPaymentOption(2, 'Google Pay', Icons.account_balance_wallet),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Order Summary'),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal'),
                Text('\$549.00'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping'),
                Text('\$15.00'),
              ],
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '\$564.00',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              text: 'Place Order',
              isLoading: _isLoading,
              onPressed: () {
                setState(() => _isLoading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    context.go('/order-success');
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildPaymentOption(int index, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: _selectedPayment == index
              ? Theme.of(context).primaryColor
              : Colors.grey.shade300,
          width: _selectedPayment == index ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RadioListTile(
        value: index,
        groupValue: _selectedPayment,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (val) {
          setState(() => _selectedPayment = val!);
        },
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        secondary: Icon(icon, color: Colors.grey[700]),
      ),
    );
  }
}
