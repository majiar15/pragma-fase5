import 'package:fase5/main.dart';
import 'package:fase5/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductModel, DiscountedProduct, ProductCartUIModel;
import 'package:store_design_system/store_design_system.dart';

class CatalogPage extends StatelessWidget {
  final List<DiscountedProduct> productsSimilar;
  final List<String> categories;
  final Function(ProductModel) onTapProductSimilar;
  final Function(ProductModel) onTapAddCart;
  const CatalogPage({
    super.key,
    required this.productsSimilar,
    required this.onTapProductSimilar,
    required this.onTapAddCart,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = Injector.of(context).cartBloc;


    return CatalogTemplate(
      onTapAddCart: (product) {
        cartBloc.addItem(
          ProductCartUIModel(
            productId: product.id!,
            title: product.title,
            price: product.price,
            image: product.image,
            quantity: 1
          )
        );
      },
      onTapProductSimilar: onTapProductSimilar,
      productList: productsSimilar,
      categories: categories,
    );
  }
}
