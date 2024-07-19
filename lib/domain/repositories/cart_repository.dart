
import 'package:flutter_models_commons/flutter_models_commons.dart' show  ProductCartUIModel;

abstract class CartRepository {

  List<ProductCartUIModel> getCart();
  List<ProductCartUIModel> addItem(ProductCartUIModel product);
  List<ProductCartUIModel> removeItem(ProductCartUIModel product);

}