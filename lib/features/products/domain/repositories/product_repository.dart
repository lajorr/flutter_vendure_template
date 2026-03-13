import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int take = 10,
    int skip = 0,
  });
  Future<Either<Failure, Product>> getProductDetails(String slug);
}
