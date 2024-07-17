import 'package:fase5/domain/repositories/category_repository.dart';

class CategoryUseCase {
  final CategoryRepository _categoryRepository;

  CategoryUseCase(this._categoryRepository);

  Future<List<String>> getAllCategories() =>
      _categoryRepository.getAllCategories();
}
