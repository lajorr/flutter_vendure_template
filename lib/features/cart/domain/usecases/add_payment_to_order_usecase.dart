import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

class AddPaymentToOrderUsecase
    extends Usecase<void, AddPaymentToOrderUsecaseParams> {
  final CartRepository _repository;

  AddPaymentToOrderUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(AddPaymentToOrderUsecaseParams params) {
    return _repository.addPaymentToOrder(
      method: params.method,
      metadata: params.metadata,
    );
  }
}

class AddPaymentToOrderUsecaseParams {
  final String method;
  final Map<String, dynamic>? metadata;

  AddPaymentToOrderUsecaseParams({required this.method, this.metadata});
}
