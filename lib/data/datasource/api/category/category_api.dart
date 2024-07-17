
import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:fase5/domain/repositories/category_repository.dart';

class CategoryApi extends CategoryRepository {

  final client = ApiFakeStorageORM();

  @override
  Future<List<String>> getAllCategories() async {
    try {
      return await client.category.getAll();
    } catch (e) {
      rethrow;
    }
  }
}
