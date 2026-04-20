import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/repository_exception_handler.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl with RepositoryExceptionMixin implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int take = 10,
    int skip = 0,
  }) async {
    return exceptionHandler(() async {
      final models = await _remoteDataSource.getProducts(
        take: take,
        skip: skip,
      );
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Product>> getProductDetails(String id) async {
    return exceptionHandler(() async {
      final model = await _remoteDataSource.getProductDetails(id);
      return model.toEntity();
    });
  }
}
