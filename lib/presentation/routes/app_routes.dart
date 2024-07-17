import 'package:fase5/presentation/modules/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:fase5/presentation/modules/login/login_page.dart';
import 'package:fase5/presentation/modules/product_detail/product_detail.dart';
import 'package:fase5/presentation/modules/home/home_page.dart';
import 'package:fase5/presentation/modules/catalog/catalog_page.dart';
import 'package:fase5/presentation/modules/forgot_password/forgot_password_page.dart';

import 'routes.dart';

Map<String, Widget Function(BuildContext)>  get appRoutes {
  return {
    Routes.login : (_) => const LoginPage(),
    Routes.home : (_) => const HomePage(),
    Routes.forgotPassword : (_) => ForgotPasswordPage(),
    Routes.register : (_) => RegisterPage(),
    Routes.productDetail: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return ProductDetailPage(
        product: args['product'],
        productsSimilar: args['productsSimilar'],
        onTapProductSimilar: args['onTapProductSimilar'],
        onTapAddCart: args['onTapAddCart'],
      );
    },
    Routes.catalog: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return CatalogPage(
        productsSimilar: args['productsSimilar'],
        onTapProductSimilar: args['onTapProductSimilar'],
        onTapAddCart: args['onTapAddCart'],
      );
    },
  };
}