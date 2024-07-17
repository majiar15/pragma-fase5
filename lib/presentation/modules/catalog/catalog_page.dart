import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductModel;
import 'package:store_design_system/store_design_system.dart';

class CatalogPage extends StatelessWidget {
  final List<ProductModel> productsSimilar;
  final Function(ProductModel) onTapProductSimilar;
  final Function(ProductModel) onTapAddCart;
  const CatalogPage({
    super.key,
    required this.productsSimilar,
    required this.onTapProductSimilar,
    required this.onTapAddCart,
  });

  @override
  Widget build(BuildContext context) {
    return CatalogTemplate(
      onTapAddCart: onTapAddCart,
      onTapProductSimilar: onTapProductSimilar,
      productList: productsSimilar,
      categories: const [],
    );
  }
}
