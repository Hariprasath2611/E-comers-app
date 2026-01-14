import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Reuse Products for demo
    final List<Map<String, String>> products = [
      {'id': '1', 'title': 'Nike Air Max 270', 'price': '\$150.00', 'image': ''},
      {'id': '3', 'title': 'Leather Backpack', 'price': '\$89.00', 'image': ''},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                   const SizedBox(height: 16),
                   const Text('Your wishlist is empty'),
                   const SizedBox(height: 16),
                   TextButton(
                    onPressed: () => context.go('/home'), 
                    child: const Text('Find Products')
                   ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    id: product['id']!,
                    title: product['title']!,
                    price: product['price']!,
                    imageUrl: product['image']!,
                    onTap: () => context.push('/product/${product['id']}'),
                  ).animate().fadeIn().moveY(begin: 20, end: 0);
                },
              ),
            ),
    );
  }
}
