import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetailsUseCase implements UseCase<Product, String> {
  final ProductRepository _repository;

  GetProductDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, Product>> execute(String slug) {
    if (slug.isEmpty) {
      return Future.value(const Left(ServerFailure('Slug cannot be empty')));
    }
    return _repository.getProductDetails(slug);
  }
}
