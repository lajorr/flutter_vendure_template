import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:vendure_flutter_app/shared/models/create_address_input.dart';

class SetBillingAddressUsecase extends Usecase<void, CreateAddressInput> {
  final CartRepository _repository;

  SetBillingAddressUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(CreateAddressInput params) async {
    return await _repository.setBillingAddress(address: params);
  }
}
