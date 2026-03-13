import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase implements UseCase<List<Product>, ProductsParams> {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Product>>> execute(ProductsParams params) {
    return _repository.getProducts(take: params.take, skip: params.skip);
  }
}

class ProductsParams {
  final int take;
  final int skip;

  ProductsParams({this.take = 10, this.skip = 0});
}
