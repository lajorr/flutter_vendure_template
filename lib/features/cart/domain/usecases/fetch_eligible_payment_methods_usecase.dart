import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/payment_method.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

class FetchEligiblePaymentMethodsUsecase
    extends Usecase<List<PaymentMethod>, NoParams> {
  final CartRepository _repository;

  FetchEligiblePaymentMethodsUsecase(this._repository);
  @override
  Future<Either<Failure, List<PaymentMethod>>> execute(NoParams params) async {
    return await _repository.fetchEligiblePaymentMethods();
  }
}
