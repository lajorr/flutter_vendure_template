import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/active_order.dart';

abstract class CartRepository {
  Future<Either<Failure, ActiveOrder?>> fetchActiveOrder();
  Future<Either<Failure, void>> addItemToOrder({
    required String productVariantId,
    required int quantity,
  });
}
