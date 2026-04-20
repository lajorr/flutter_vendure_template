import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/active_order.dart';
import '../repositories/cart_repository.dart';

class FetchActiveOrderUseCase implements UseCase<ActiveOrder?, NoParams> {
  final CartRepository _repository;

  FetchActiveOrderUseCase(this._repository);

  @override
  Future<Either<Failure, ActiveOrder?>> execute(NoParams params) {
    return _repository.fetchActiveOrder();
  }
}
