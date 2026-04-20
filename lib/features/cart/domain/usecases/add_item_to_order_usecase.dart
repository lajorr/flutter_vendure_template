import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

class AddItemToOrderUseCase extends Usecase<void, AddItemToOrderUseCaseParams> {
  final CartRepository repository;

  AddItemToOrderUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(
    AddItemToOrderUseCaseParams params,
  ) async {
    return await repository.addItemToOrder(
      productVariantId: params.variantId,
      quantity: params.quantity,
    );
  }
}

class AddItemToOrderUseCaseParams {
  final String variantId;
  final int quantity;

  AddItemToOrderUseCaseParams({
    required this.variantId,
    required this.quantity,
  });
}
