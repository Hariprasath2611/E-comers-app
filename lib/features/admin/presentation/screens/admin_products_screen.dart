import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';
import 'package:ecommerce_app/features/products/presentation/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../products/presentation/providers/product_providers.dart';
import '../../products/data/models/product_model.dart';
import '../../products/domain/entities/product.dart';

class AdminProductsScreen extends ConsumerStatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  ConsumerState<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends ConsumerState<AdminProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Products',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () => _seedDatabase(context, ref),
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Seed DB'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => _showAddEditDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Product'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: productsAsync.when(
                  data: (products) => SingleChildScrollView(
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(Colors.grey[50]),
                      columns: const [
                        DataColumn(label: Text('Product Name')),
                        DataColumn(label: Text('Price')),
                        DataColumn(label: Text('Stock')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: products.map((product) {
                        return DataRow(cells: [
                          DataCell(Text(product.title)),
                          DataCell(Text('\$${product.price}')),
                          DataCell(
                            Chip(
                              label: Text('${product.stock}'),
                              backgroundColor: product.stock < 20
                                  ? Colors.red[50]
                                  : Colors.green[50],
                              labelStyle: TextStyle(
                                  color: product.stock < 20
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ),
                          DataCell(Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showAddEditDialog(context, product: product),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await ref.read(productRepositoryProvider).deleteProduct(product.id);
                                  ref.refresh(productsProvider);
                                },
                              ),
                            ],
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditDialog(BuildContext context, {Product? product}) {
    final titleController = TextEditingController(text: product?.title);
    final priceController = TextEditingController(text: product?.price.toString());
    final stockController = TextEditingController(text: product?.stock.toString());
    final imageController = TextEditingController(text: product?.imageUrl); // Simple text field for URL for now

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            const SizedBox(height: 16),
             TextField(
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              controller: priceController,
            ),
             const SizedBox(height: 16),
             TextField(
              decoration: const InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
              controller: stockController,
            ),
            const SizedBox(height: 16),
             TextField(
              decoration: const InputDecoration(labelText: 'Image URL'),
              controller: imageController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newProduct = ProductModel(
                id: product?.id ?? const Uuid().v4(),
                title: titleController.text,
                description: product?.description ?? 'No description',
                price: double.tryParse(priceController.text) ?? 0.0,
                imageUrl: imageController.text,
                stock: int.tryParse(stockController.text) ?? 0,
              );

              await ref.read(productRepositoryProvider).addProduct(newProduct);
              ref.refresh(productsProvider);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }


  Future<void> _seedDatabase(BuildContext context, WidgetRef ref) async {
    // Initial seed data
    final List<ProductModel> seedProducts = [
      const ProductModel(
        id: '1',
        title: 'Fintech Dashboard',
        description: 'Category: ui-kits. Tech: Figma File.',
        price: 15.00,
        imageUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=600&q=80',
        stock: 10,
      ),
      const ProductModel(
        id: '2',
        title: 'Sci-Fi Weapon Pack',
        description: 'Category: 3d-models. Tech: Blender File.',
        price: 34.00,
        imageUrl: 'https://images.unsplash.com/photo-1614332287897-cdc485fa562d?auto=format&fit=crop&w=600&q=80',
        stock: 5,
      ),
      const ProductModel(
        id: '3',
        title: 'karthick',
        description: 'Category: websites. Tech: react.',
        price: 46.00,
        imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?auto=format&fit=crop&w=600&q=80',
        stock: 8,
      ),
      const ProductModel(
        id: '4',
        title: 'Crypto Exchange Script',
        description: 'Category: scripts. Tech: NodeJS / Mongo.',
        price: 120.00,
        imageUrl: 'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?auto=format&fit=crop&w=600&q=80',
        stock: 3,
      ),
      const ProductModel(
        id: '5',
        title: '2D Platformer Kit',
        description: 'Category: games. Tech: Unity Package.',
        price: 19.99,
        imageUrl: 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&w=600&q=80',
        stock: 20,
      ),
      const ProductModel(
        id: '6',
        title: 'Cyberpunk Character',
        description: 'Category: 3d-models. Tech: .OBJ / .FBX.',
        price: 55.00,
        imageUrl: 'https://images.unsplash.com/photo-1635322966219-b75ed372eb01?auto=format&fit=crop&w=600&q=80',
        stock: 7,
      ),
      const ProductModel(
        id: '7',
        title: 'Fitness Tracker UI',
        description: 'Category: apps. Tech: Swift / iOS.',
        price: 24.00,
        imageUrl: 'https://images.unsplash.com/photo-1555774698-0b77e0d5fac6?auto=format&fit=crop&w=600&q=80',
        stock: 12,
      ),
      const ProductModel(
        id: '8',
        title: 'SaaS Landing Page',
        description: 'Category: websites. Tech: React / Tailwind.',
        price: 29.00,
        imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=600&q=80',
        stock: 15,
      ),
      const ProductModel(
        id: '9',
        title: 'Food Delivery App',
        description: 'Category: apps. Tech: Flutter / Dart.',
        price: 45.00,
        imageUrl: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?auto=format&fit=crop&w=600&q=80',
        stock: 6,
      ),
      const ProductModel(
        id: '10',
        title: 'RPG Environment',
        description: 'Category: games. Tech: Unreal Engine 5.',
        price: 89.99,
        imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=600&q=80',
        stock: 4,
      ),
    ];

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    try {
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator())
      );

      final repository = ref.read(productRepositoryProvider);
      
      for (final product in seedProducts) {
        await repository.addProduct(product);
      }
      
      if (context.mounted) {
        Navigator.pop(context); // Pop loading
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Database seeded successfully!')),
        );
        ref.refresh(productsProvider);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Pop loading
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error seeding database: $e')),
        );
      }
    }
  }
}
