import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class MockProductRepository implements ProductRepository {
  final List<Product> _mockProducts = [
    const Product(
      id: '1',
      title: 'Fintech Dashboard',
      description: 'Category: ui-kits. Tech: Figma File.',
      price: 15.00,
      imageUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=600&q=80',
      stock: 10,
    ),
    const Product(
      id: '2',
      title: 'Sci-Fi Weapon Pack',
      description: 'Category: 3d-models. Tech: Blender File.',
      price: 34.00,
      imageUrl: 'https://images.unsplash.com/photo-1614332287897-cdc485fa562d?auto=format&fit=crop&w=600&q=80',
      stock: 5,
    ),
    const Product(
      id: '3',
      title: 'karthick', // Keeping original title from scrape
      description: 'Category: websites. Tech: react.',
      price: 46.00,
      imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?auto=format&fit=crop&w=600&q=80',
      stock: 8,
    ),
    const Product(
      id: '4',
      title: 'Crypto Exchange Script',
      description: 'Category: scripts. Tech: NodeJS / Mongo.',
      price: 120.00,
      imageUrl: 'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?auto=format&fit=crop&w=600&q=80',
      stock: 3,
    ),
    const Product(
      id: '5',
      title: '2D Platformer Kit',
      description: 'Category: games. Tech: Unity Package.',
      price: 19.99,
      imageUrl: 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&w=600&q=80',
      stock: 20,
    ),
    const Product(
      id: '6',
      title: 'Cyberpunk Character',
      description: 'Category: 3d-models. Tech: .OBJ / .FBX.',
      price: 55.00,
      imageUrl: 'https://images.unsplash.com/photo-1635322966219-b75ed372eb01?auto=format&fit=crop&w=600&q=80',
      stock: 7,
    ),
    const Product(
      id: '7',
      title: 'Fitness Tracker UI',
      description: 'Category: apps. Tech: Swift / iOS.',
      price: 24.00,
      imageUrl: 'https://images.unsplash.com/photo-1555774698-0b77e0d5fac6?auto=format&fit=crop&w=600&q=80',
      stock: 12,
    ),
    const Product(
      id: '8',
      title: 'SaaS Landing Page',
      description: 'Category: websites. Tech: React / Tailwind.',
      price: 29.00,
      imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=600&q=80',
      stock: 15,
    ),
     const Product(
      id: '9',
      title: 'Food Delivery App',
      description: 'Category: apps. Tech: Flutter / Dart.',
      price: 45.00,
      imageUrl: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?auto=format&fit=crop&w=600&q=80',
      stock: 6,
    ),
    const Product(
      id: '10',
      title: 'RPG Environment',
      description: 'Category: games. Tech: Unreal Engine 5.',
      price: 89.99,
      imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=600&q=80',
      stock: 4,
    ),
  ];

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return Right(_mockProducts);
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      final product = _mockProducts.firstWhere((p) => p.id == id);
      return Right(product);
    } catch (e) {
      return const Left(ServerFailure('Product not found'));
    }
  }

  @override
  Future<Either<Failure, void>> addProduct(Product product) async {
    _mockProducts.add(product);
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    _mockProducts.removeWhere((p) => p.id == id);
    return const Right(null);
  }
}
