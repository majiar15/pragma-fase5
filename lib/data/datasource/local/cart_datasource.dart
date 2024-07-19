
import 'package:fase5/domain/repositories/cart_repository.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductCartUIModel, CartUIModel;

class CartDataSource extends CartRepository {

  static final CartDataSource _instance = CartDataSource._internal();

  CartDataSource._internal();

  factory CartDataSource() {
    return _instance;
  }

  final List<ProductCartUIModel> cart = [];

  @override
  List<ProductCartUIModel> addItem(ProductCartUIModel product) {
    int index = cart.indexWhere((producto) => producto.productId == product.productId);
    if (index == -1) {
      cart.add(product);
    } else {
     cart[index].quantity++;
    }
    return cart;
  }

  @override
  List<ProductCartUIModel> removeItem(ProductCartUIModel product) {
    int index = cart.indexWhere((producto) => producto.productId == product.productId);
    if (index != -1) {
      return cart;
    } else {
      if(cart[index].quantity == 1){
        cart.remove(cart[index]);
        return cart;
      }
     cart[index].quantity--;
    }
    return cart;
  }

  @override
  List<ProductCartUIModel> getCart() {
    return cart;
  }
}
