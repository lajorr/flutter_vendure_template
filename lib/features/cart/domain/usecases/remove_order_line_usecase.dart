import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

class RemoveOrderLineUsecase extends Usecase<ActiveOrder, String> {
  final OrderLineRepository repository;

  RemoveOrderLineUsecase(this.repository);

  @override
  Future<Either<Failure, ActiveOrder>> execute(String lineId) async {
    return await repository.removeOrderLine(orderLineId: lineId);
  }
}
