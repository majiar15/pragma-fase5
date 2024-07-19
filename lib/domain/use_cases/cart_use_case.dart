import 'package:fase5/domain/repositories/cart_repository.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductCartUIModel;

class CartUseCase {
  final CartRepository _cartRepository;

  CartUseCase(this._cartRepository);

  List<ProductCartUIModel> getCart() =>
      _cartRepository.getCart();
  List<ProductCartUIModel> removeItem(ProductCartUIModel product) =>
      _cartRepository.removeItem(product);

  List<ProductCartUIModel> addItem(ProductCartUIModel product) =>
      _cartRepository.addItem(product);
  List<ProductCartUIModel> cleanCart() =>
      _cartRepository.cleanCart();
}
