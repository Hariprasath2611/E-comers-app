import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class AuthRepository {
  Future<Either<Failure, firebase_auth.User>> signInWithEmail(String email, String password);
  Future<Either<Failure, firebase_auth.User>> signUpWithEmail(String name, String email, String password);
  Future<Either<Failure, void>> signOut();
  Stream<firebase_auth.User?> get authStateChanges;
}

// Simple Failure class if not exists
class Failure {
  final String message;
  const Failure(this.message);
}
