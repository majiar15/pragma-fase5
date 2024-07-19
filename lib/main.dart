import 'package:fase5/app.dart';
import 'package:fase5/data/datasource/api/auth/auth_api.dart';
import 'package:fase5/data/datasource/api/category/category_api.dart';
import 'package:fase5/data/datasource/api/product/product_api.dart';
import 'package:fase5/data/datasource/local/cart_datasource.dart';
import 'package:fase5/domain/repositories/auth_repository.dart';
import 'package:fase5/domain/repositories/cart_repository.dart';
import 'package:fase5/domain/repositories/category_repository.dart';
import 'package:fase5/domain/repositories/product_repository.dart';
import 'package:fase5/domain/use_cases/auth_use_case.dart';
import 'package:fase5/domain/use_cases/cart_use_case.dart';
import 'package:fase5/domain/use_cases/category_use_case.dart';
import 'package:fase5/domain/use_cases/product_use_case.dart';
import 'package:fase5/presentation/bloc/auth_bloc.dart';
import 'package:fase5/presentation/bloc/cart_bloc.dart';
import 'package:fase5/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';


void main(){
  AuthRepository authRepository = AuthApi();
  ProductRepository productRepository = ProductApi();
  CategoryRepository categoryRepository = CategoryApi();
  CartRepository cartRepository = CartDataSource();

  runApp(
    Injector(
      authBloc: AuthBloc(
        AuthUseCase(authRepository),
      ),
      homeBloc: HomeBloc(
        ProductUseCase(productRepository),
        CategoryUseCase(categoryRepository)
      ),
      cartBloc: CartBloc(
        CartUseCase(cartRepository)
      ),
      child: const App()
    )
  );
}

class Injector extends InheritedWidget {

  const Injector({
    super.key,
    required super.child,
    required this.authBloc,
    required this.homeBloc,
    required this.cartBloc,
  });

  final AuthBloc authBloc;
  final HomeBloc homeBloc;
  final CartBloc cartBloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static Injector of(BuildContext context){
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, "injector not found");
    return injector!;
  }

}