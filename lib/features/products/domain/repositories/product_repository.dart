import 'package:fpdart/fpdart.dart';
import '../entities/product.dart'; 
import '../../../../core/error/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, void>> addProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String id);
}

