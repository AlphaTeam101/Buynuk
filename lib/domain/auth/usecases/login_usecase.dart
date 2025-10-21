import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Either<String, User>> call({
    required String email,
    required String password,
  }) async {
    return await _authRepository.login(email, password);
  }
}
