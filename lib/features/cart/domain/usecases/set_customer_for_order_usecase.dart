import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:vendure_flutter_app/shared/models/create_customer_input.dart';

class SetCustomerForOrderUseCase
    implements Usecase<ActiveOrder, CreateCustomerInput> {
  final CartRepository _repository;

  SetCustomerForOrderUseCase(this._repository);

  @override
  Future<Either<Failure, ActiveOrder>> execute(CreateCustomerInput params) {
    return _repository.setCustomerForOrder(customerInput: params);
  }
}
