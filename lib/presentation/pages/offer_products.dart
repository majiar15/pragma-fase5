import 'package:fase5/main.dart';
import 'package:fase5/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show DiscountedProduct, ProductCartUIModel;
import 'package:store_design_system/store_design_system.dart';

class OfferProductsPage extends StatelessWidget {
  final List<DiscountedProduct> products;
  final List<DiscountedProduct> productsSimilar;
  final Function(DiscountedProduct) onTapProductSimilar;
  final Function(DiscountedProduct) onTapAddCart;
  const OfferProductsPage({
    super.key,
    required this.products,
    required this.productsSimilar,
    required this.onTapProductSimilar,
    required this.onTapAddCart,
  });

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = Injector.of(context).cartBloc;

    return OfferTemplate(
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
      productsSimilar: productsSimilar,
      onTapProductSimilar: onTapProductSimilar,
      productList: products,
    );
  }
}
