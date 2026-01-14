import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard Overview',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard(
                context,
                title: 'Total Sales',
                value: '\$12,450',
                icon: Icons.attach_money,
                color: Colors.green,
              ),
              _buildStatCard(
                context,
                title: 'Total Orders',
                value: '456',
                icon: Icons.shopping_cart,
                color: Colors.blue,
              ),
              _buildStatCard(
                context,
                title: 'Total Users',
                value: '1,234',
                icon: Icons.people,
                color: Colors.orange,
              ),
              _buildStatCard(
                context,
                title: 'Products',
                value: '89',
                icon: Icons.inventory_2,
                color: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 48),
          const Text(
            'Recent Orders',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Text('#$index'),
                    ),
                    title: Text('Order #3049$index'),
                    subtitle: Text('Jan 14, 2026 • 2 items'),
                    trailing: const Chip(
                      label: Text('Processing'),
                      backgroundColor: Color(0xFFFFF3E0),
                      labelStyle: TextStyle(color: Colors.orange),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context,
      {required String title,
      required String value,
      required IconData icon,
      required Color color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((255 * 0.05).toInt()),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withAlpha((255 * 0.1).toInt()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 16),
            Text(value,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
