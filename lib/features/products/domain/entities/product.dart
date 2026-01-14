import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final int stock;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
  });

  @override
  List<Object?> get props => [id, title, description, price, imageUrl, stock];
}