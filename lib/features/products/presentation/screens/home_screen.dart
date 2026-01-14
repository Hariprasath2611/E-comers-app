import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../core/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {}, // TODO: Search
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return Chip(
                    label: Text(_categories[index]),
                    backgroundColor: index == 0
                        ? Theme.of(context).primaryColor
                        : Colors.grey[100],
                    labelStyle: TextStyle(
                      color: index == 0 ? Colors.white : Colors.black,
                    ),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ).animate().fadeIn(delay: (50 * index).ms).slideX();
                },
              ),
            ),
            const SizedBox(height: 24),
            
            // Featured Banner
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha((255 * 0.1).toInt()),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                   Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(Icons.percent, size: 80, color: Theme.of(context).primaryColor.withAlpha((255 * 0.2).toInt())),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Summer Sale',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Up to 50% off on all items'),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().scale(),

            const SizedBox(height: 24),
            Text(
              'New Arrivals',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Product Grid
            MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ProductCard(
                  id: product['id']!,
                  title: product['title']!,
                  price: product['price']!,
                  imageUrl: product['image']!,
                  onTap: () => context.go('/product/${product['id']}'),
                ).animate().fadeIn(delay: (100 * index).ms).moveY(begin: 20, end: 0);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Mock Data
final List<String> _categories = ['All', 'Shoes', 'Clothes', 'Watches', 'Bags'];
final List<Map<String, String>> _products = [
  {'id': '1', 'title': 'Nike Air Max 270', 'price': '\$150.00', 'image': ''},
  {'id': '2', 'title': 'Apple Watch Series 9', 'price': '\$399.00', 'image': ''},
  {'id': '3', 'title': 'Leather Backpack', 'price': '\$89.00', 'image': ''},
  {'id': '4', 'title': 'Denim Jacket', 'price': '\$65.00', 'image': ''},
  {'id': '5', 'title': 'Wireless Headphones', 'price': '\$129.00', 'image': ''},
  {'id': '6', 'title': 'Running Shoes', 'price': '\$95.00', 'image': ''},
];
