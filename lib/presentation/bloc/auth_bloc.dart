import 'dart:async';

import 'package:fase5/domain/use_cases/auth_use_case.dart';

class AuthBloc {
  final AuthUseCase _authUseCases;
  final _authController = StreamController<String>();

  Stream<String> get stream => _authController.stream;

  AuthBloc(this._authUseCases);

  void login(String userName, password) async {
    try {
      final token = await _authUseCases.login(userName, password);
      _authController.add(token);
    } catch (e) {
      _authController.addError(e);
    }
  }

  void dispose() {
    _authController.close();
  }
}