

import 'package:api_fake_storage_orm/api_fake_storage_orm.dart' as api;
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductModel;


abstract class ProductRepository {

  Future<List<ProductModel>> getAllProducts([api.Sort? sort, int? limit]);
  Future<ProductModel> getProductById(int productId);
  Future<List<ProductModel>> getProductByCategory(String category);
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<ProductModel> deleteProduct(int productId);

}