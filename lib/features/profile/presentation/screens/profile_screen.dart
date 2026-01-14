import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha((255 * 0.1).toInt()),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, size: 50, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text('john.doe@example.com', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ).animate().scale(),
            const SizedBox(height: 32),
            _buildProfileTile(
              context,
              icon: Icons.list_alt,
              title: 'My Orders',
              onTap: () => context.push('/orders'),
            ),
             _buildProfileTile(
              context,
              icon: Icons.location_on_outlined,
              title: 'Shipping Address',
              onTap: () {},
            ),
             _buildProfileTile(
              context,
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              onTap: () {},
            ),
             _buildProfileTile(
              context,
              icon: Icons.favorite_outline,
              title: 'Wishlist',
              onTap: () => context.go('/wishlist'),
            ),
             _buildProfileTile(
              context,
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => context.go('/login'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
