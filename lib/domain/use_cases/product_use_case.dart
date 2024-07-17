import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductModel;
import 'package:fase5/domain/repositories/product_repository.dart';

class ProductUseCase {
  final ProductRepository _productRepository;

  ProductUseCase(this._productRepository);

  Future<List<ProductModel>> getAllProducts() =>
      _productRepository.getAllProducts();
}
