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
}
