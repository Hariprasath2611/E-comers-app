import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminScaffold extends StatelessWidget {
  final Widget child;

  const AdminScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 32),
                const Icon(Icons.admin_panel_settings,
                    size: 60, color: Color(0xFF6750A4)),
                const SizedBox(height: 16),
                const Text(
                  'Admin Panel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                _AdminMenuItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  route: '/admin/dashboard',
                ),
                _AdminMenuItem(
                  icon: Icons.shopping_bag,
                  title: 'Products',
                  route: '/admin/products',
                ),
                _AdminMenuItem(
                  icon: Icons.list_alt,
                  title: 'Orders',
                  route: '/admin/orders',
                ),
                const Spacer(),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title:
                      const Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () => context.go('/admin/login'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          // Content Area
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const _AdminMenuItem({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = GoRouterState.of(context).uri.path == route;
    return ListTile(
      leading: Icon(icon, color: isSelected ? const Color(0xFF6750A4) : null),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF6750A4) : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      selected: isSelected,
      onTap: () => context.go(route),
    );
  }
}
