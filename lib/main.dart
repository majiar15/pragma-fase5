import 'package:fase5/app.dart';
import 'package:fase5/data/datasource/api/auth/auth_api.dart';
import 'package:fase5/domain/repositories/auth_repository.dart';
import 'package:fase5/domain/use_cases/auth_use_case.dart';
import 'package:fase5/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';


void main(){
  AuthRepository productRepository = AuthApi();
  runApp(
    Injector(
      authBloc: AuthBloc(
        AuthUseCase(productRepository)
      ),
      child: const App()
    )
  );
}

class Injector extends InheritedWidget {

  const Injector({
    super.key,
    required super.child,
    required this.authBloc
  });

  final AuthBloc authBloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }

  static Injector of(BuildContext context){
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, "injector not found");
    return injector!;
  }

}