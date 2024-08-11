import 'package:fase5/domain/repositories/discount_repository.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';

class DiscountedUseCase {
  final DiscountedRepository _discountedRepository;

  DiscountedUseCase(this._discountedRepository);

  addProductDiscounted(List<DiscountedProduct> products) =>
      _discountedRepository.addProductDiscounted(products);

  getAllProductDiscounted() =>
      _discountedRepository.getProductsDiscounted();
}
