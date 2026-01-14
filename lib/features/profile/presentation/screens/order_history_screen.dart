import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {'id': '#30492', 'date': 'Jan 14, 2026', 'total': '\$150.00', 'status': 'Processing'},
      {'id': '#30491', 'date': 'Jan 10, 2026', 'total': '\$89.00', 'status': 'Delivered'},
      {'id': '#30490', 'date': 'Jan 05, 2026', 'total': '\$399.00', 'status': 'Delivered'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final order = orders[index];
          final isDelivered = order['status'] == 'Delivered';
          
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['id']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDelivered ? Colors.green[50] : Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        order['status']!,
                        style: TextStyle(
                          color: isDelivered ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order['date']!, style: TextStyle(color: Colors.grey[600])),
                    Text(order['total']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(delay: (100 * index).ms).slideX();
        },
      ),
    );
  }
}
