import 'package:fase5/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<String> login(String userName, String password) =>
      _authRepository.login(userName, password);
}
