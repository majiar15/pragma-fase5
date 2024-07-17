
import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show ProductModel;
import 'package:fase5/domain/repositories/product_repository.dart';

class ProductApi extends ProductRepository {

  final client = ApiFakeStorageORM();

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      return await client.product.create(product);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> deleteProduct(int productId) async {
    try {
      return await client.product.delete(productId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts([Sort? sort, int? limit]) async {
    try {
      return await client.product.getAll(sort: sort, limit: limit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getProductByCategory(String category) async {
    try {
      return await client.product.getByCategory(category);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductById(int productId) async {
    try {
      return await client.product.getOne(productId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      return await client.product.update(product);
    } catch (e) {
      rethrow;
    }
  }
}
