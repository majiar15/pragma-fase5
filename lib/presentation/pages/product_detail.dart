import 'package:fase5/main.dart';
import 'package:fase5/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show DiscountedProduct, ProductCartUIModel;
import 'package:store_design_system/templates.dart';

class ProductDetailPage extends StatelessWidget {
  final DiscountedProduct product;
  final List<DiscountedProduct> productsSimilar;
  final int discountPercentage;
  final Function(DiscountedProduct) onTapProductSimilar;
  const ProductDetailPage({
    super.key,
    required this.product,
    this.discountPercentage = 0,
    required this.productsSimilar,
    required this.onTapProductSimilar,
  });


  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = Injector.of(context).cartBloc;
    return ProductDetailTemplate(
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
      discountPercentage: discountPercentage,
      onTapProductSimilar: onTapProductSimilar,
      product: product,
      productList: productsSimilar,
    );
  }
}
