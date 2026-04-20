import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

class AdjustOrderItemQuantityUsecase
    extends Usecase<ActiveOrder, AdjustOrderItemQuantityUsecaseParams> {
  final CartRepository repository;

  AdjustOrderItemQuantityUsecase(this.repository);

  @override
  Future<Either<Failure, ActiveOrder>> execute(
    AdjustOrderItemQuantityUsecaseParams params,
  ) async {
    return await repository.adjustOrderItemQuantity(
      orderLineId: params.orderLineId,
      quantity: params.quantity,
    );
  }
}

class AdjustOrderItemQuantityUsecaseParams {
  final String orderLineId;
  final int quantity;

  AdjustOrderItemQuantityUsecaseParams({
    required this.orderLineId,
    required this.quantity,
  });
}
