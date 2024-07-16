
import 'package:api_fake_storage_orm/api_fake_storage_orm.dart';
import 'package:fase5/domain/repositories/auth_repository.dart';

class AuthApi extends AuthRepository {

  @override
  Future<String> login(String userName, String password) async {
    try {
      final ApiFakeStorageORM client = ApiFakeStorageORM();
      return await client.auth.login(userName, password);
    } catch (e) {
      rethrow;
    }
  }

}