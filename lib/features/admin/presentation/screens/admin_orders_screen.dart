import 'package:flutter/material.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  // Mock Data
  final List<Map<String, dynamic>> _orders = [
    {'id': '#30490', 'user': 'John Doe', 'total': 150.00, 'status': 'Delivered', 'date': 'Jan 14, 2026'},
    {'id': '#30491', 'user': 'Jane Smith', 'total': 89.00, 'status': 'Processing', 'date': 'Jan 14, 2026'},
    {'id': '#30492', 'user': 'Robert Brown', 'total': 399.00, 'status': 'Shipped', 'date': 'Jan 13, 2026'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Orders',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
                  columns: const [
                    DataColumn(label: Text('Order ID')),
                    DataColumn(label: Text('Customer')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Total')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _orders.map((order) {
                    return DataRow(cells: [
                      DataCell(Text(order['id'])),
                      DataCell(Text(order['user'])),
                      DataCell(Text(order['date'])),
                      DataCell(Text('\$${order['total']}')),
                      DataCell(_buildStatusChip(order['status'])),
                      DataCell(
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            setState(() {
                              order['status'] = value;
                            });
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'Processing', child: Text('Processing')),
                            const PopupMenuItem(value: 'Shipped', child: Text('Shipped')),
                            const PopupMenuItem(value: 'Delivered', child: Text('Delivered')),
                            const PopupMenuItem(value: 'Cancelled', child: Text('Cancelled')),
                          ],
                          child: const Icon(Icons.more_vert),
                        ),
                      ),
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

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Delivered':
        color = Colors.green;
        break;
      case 'Shipped':
        color = Colors.blue;
        break;
      case 'Processing':
        color = Colors.orange;
        break;
      case 'Cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(status),
      backgroundColor: color.withAlpha(50),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
      side: BorderSide.none,
    );
  }
}
