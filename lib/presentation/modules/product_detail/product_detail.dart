import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductModel;
import 'package:store_design_system/store_design_system.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> productsSimilar;
  final Function(ProductModel) onTapProductSimilar;
  final Function(ProductModel) onTapAddCart;
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.productsSimilar,
    required this.onTapProductSimilar,
    required this.onTapAddCart,
  });

  @override
  Widget build(BuildContext context) {
    return ProductDetailTemplate(
      onTapAddCart: onTapAddCart,
      onTapProductSimilar: onTapProductSimilar,
      product: product,
      productList: productsSimilar,
    );
  }
}
