import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart' hide Failure;
import '../../domain/repositories/auth_repository.dart' hide Failure;

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

// ...existing code...
  @override
  Future<Either<Failure, User>> signInWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(credential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.message ?? 'Authentication Failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
// ...existing code...

// ...existing code...


  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail(String name, String email, String password) {
    // TODO: implement signUpWithEmail
    throw UnimplementedError();
  }
}
