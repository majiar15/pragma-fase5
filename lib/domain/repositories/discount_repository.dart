
import 'package:flutter_models_commons/flutter_models_commons.dart' show  DiscountedProduct;

abstract class DiscountedRepository {

  void addProductDiscounted(List<DiscountedProduct> product);
  List<DiscountedProduct> getProductsDiscounted();

}