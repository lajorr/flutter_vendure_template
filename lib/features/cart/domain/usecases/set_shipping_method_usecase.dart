import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

class SetShippingMethodUsecase
    extends Usecase<void, SetShippingMethodUsecaseParams> {
  final CartRepository _repository;

  SetShippingMethodUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(
    SetShippingMethodUsecaseParams params,
  ) async {
    return await _repository.setShippingMethod(methodId: params.methodId);
  }
}

class SetShippingMethodUsecaseParams {
  final String methodId;

  SetShippingMethodUsecaseParams({required this.methodId});
}
