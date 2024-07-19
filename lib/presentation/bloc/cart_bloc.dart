import 'dart:async';

import 'package:fase5/domain/use_cases/cart_use_case.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart'
    show ProductCartUIModel, CartUIModel;

class CartBloc {
  final CartUseCase _cartUseCases;
  final _cartController = StreamController<List<ProductCartUIModel>>.broadcast();

  Stream<List<ProductCartUIModel>> get stream => _cartController.stream;

  CartBloc(this._cartUseCases) {
    loadCart();
  }

  void addItem(ProductCartUIModel product) {
    try {
       final cart = _cartUseCases.addItem(product);
       loadCart();
    } catch (e) {
       _cartController.addError(e);
    }
  }

  void removeItem(ProductCartUIModel product) {
    try {
       final cart = _cartUseCases.removeItem(product);
       loadCart();
    } catch (e) {
       _cartController.addError(e);
    }
  }

  void dispose() {
    _cartController.close();
  }

  void loadCart() {
    try {
       final cart = _cartUseCases.getCart();
       _cartController.add(cart);
    } catch (e) {
       _cartController.addError('Failed to load cart');
    }
  }
}
