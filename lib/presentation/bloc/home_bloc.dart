import 'dart:async';

import 'package:fase5/domain/use_cases/category_use_case.dart';
import 'package:fase5/domain/use_cases/product_use_case.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';

class HomeBloc {
  final ProductUseCase _productUseCases;
  final CategoryUseCase _categoryUseCases;

  final _allProductsController = StreamController<List<ProductModel>>();
  final _categoryController = StreamController<List<String>>();

  Stream<List<ProductModel>> get productsStream => _allProductsController.stream;
  Stream<List<String>> get categoryStream => _categoryController.stream;

  HomeBloc(
    this._productUseCases,
    this._categoryUseCases
  );

  void getAllProducts() async {
    try {
      final products = await _productUseCases.getAllProducts();
      _allProductsController.add(products);
    } catch (e) {
      _allProductsController.addError(e);
    }
  }

  void getAllCategories() async {
    try {
      final categories = await _categoryUseCases.getAllCategories();
      _categoryController.add(categories);
    } catch (e) {
      _categoryController.addError(e);
    }
  }

  void dispose() {
    _allProductsController.close();
    _categoryController.close();
  }
}