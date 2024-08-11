import 'dart:async';

import 'package:fase5/domain/use_cases/category_use_case.dart';
import 'package:fase5/domain/use_cases/discounted_use_case.dart';
import 'package:fase5/domain/use_cases/product_use_case.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';

class HomeBloc {
  final ProductUseCase _productUseCases;
  final CategoryUseCase _categoryUseCases;
  final DiscountedUseCase _discountedUseCase;

  final _allProductsController = StreamController<List<ProductModel>>.broadcast();
  final _categoryController = StreamController<List<String>>.broadcast();
  final _discountedController = StreamController<List<DiscountedProduct>>.broadcast();

  Stream<List<ProductModel>> get productsStream => _allProductsController.stream;
  Stream<List<DiscountedProduct>> get productsDiscountsStream => _discountedController.stream;
  Stream<List<String>> get categoryStream => _categoryController.stream;

  HomeBloc(
    this._productUseCases,
    this._categoryUseCases,
    this._discountedUseCase
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
  void setProductDiscount(List<DiscountedProduct> productDiscount) async {
    try {
      await _discountedUseCase.addProductDiscounted(productDiscount);
    } catch (e) {
      _discountedController.addError(e);
    }
  }
  void getProductDiscount() async {
    try {
      final productsDiscounted = await _discountedUseCase.getAllProductDiscounted();
      _discountedController.add(productsDiscounted);
    } catch (e) {
      _discountedController.addError(e);
    }
  }

  void dispose() {
    _allProductsController.close();
    _categoryController.close();
  }
}