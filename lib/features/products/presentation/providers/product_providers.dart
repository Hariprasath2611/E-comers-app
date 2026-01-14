import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../data/repositories/product_repository_impl.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(FirebaseFirestore.instance);
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  final result = await repository.getProducts();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (products) => products,
  );
});

final productProvider = FutureProvider.family<Product, String>((ref, id) async {
  final repository = ref.watch(productRepositoryProvider);
  final result = await repository.getProductById(id);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (product) => product,
  );
});
