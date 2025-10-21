import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<String, User>> login(String email, String password);
  Future<Either<String, User>> getProfile();
  Future<void> logout();
}
