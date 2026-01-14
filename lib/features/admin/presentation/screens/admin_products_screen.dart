import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminProductsScreen extends ConsumerStatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  ConsumerState<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends ConsumerState<AdminProductsScreen> {
  // Mock Data
  final List<Map<String, dynamic>> _products = [
    {'id': '1', 'title': 'Nike Air Max 270', 'price': 150.00, 'stock': 45},
    {'id': '2', 'title': 'Apple Watch Series 9', 'price': 399.00, 'stock': 12},
    {'id': '3', 'title': 'Leather Backpack', 'price': 89.00, 'stock': 28},
  ];

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.black.withAlpha(10), // Fix deprecation
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
                  columns: const [
                    DataColumn(label: Text('Product Name')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Stock')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _products.map((product) {
                    return DataRow(cells: [
                      DataCell(Text(product['title'])),
                      DataCell(Text('\$${product['price']}')),
                      DataCell(
                        Chip(
                          label: Text('${product['stock']}'),
                          backgroundColor: product['stock'] < 20
                              ? Colors.red[50]
                              : Colors.green[50],
                          labelStyle: TextStyle(
                              color: product['stock'] < 20
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
                            onPressed: () {
                              setState(() {
                                _products.removeWhere((p) => p['id'] == product['id']);
                              });
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEditDialog(BuildContext context, {Map<String, dynamic>? product}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: TextEditingController(text: product?['title']),
            ),
            const SizedBox(height: 16),
             TextField(
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: product?['price']?.toString()),
            ),
             const SizedBox(height: 16),
             TextField(
              decoration: const InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: product?['stock']?.toString()),
            ),
            const SizedBox(height: 24),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 40),
                  SizedBox(height: 8),
                  Text('Upload Image'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Save logic
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
