import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

class RemoveAllOrderLineUsecase extends Usecase<ActiveOrder, NoParams> {
  final CartRepository repository;

  RemoveAllOrderLineUsecase(this.repository);

  @override
  Future<Either<Failure, ActiveOrder>> execute(NoParams params) async {
    return await repository.removeAllOrderLine();
  }
}
