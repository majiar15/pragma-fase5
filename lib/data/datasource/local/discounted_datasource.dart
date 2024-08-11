import 'package:fase5/domain/repositories/discount_repository.dart';
import 'package:flutter_models_commons/models/discounted_product_model.dart';

class DiscountDataSource extends DiscountedRepository {

  static final DiscountDataSource _instance = DiscountDataSource._internal();

  DiscountDataSource._internal();

  factory DiscountDataSource() {
    return _instance;
  }

  List<DiscountedProduct> productsDiscounted = [];

  @override
  void addProductDiscounted(List<DiscountedProduct> product) {
    productsDiscounted = List.from(product);
    
  }


  @override
  List<DiscountedProduct> getProductsDiscounted() {
    return productsDiscounted;
  }
}
