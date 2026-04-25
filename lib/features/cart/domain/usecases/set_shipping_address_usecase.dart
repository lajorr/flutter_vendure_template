import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:vendure_flutter_app/shared/models/create_address_input.dart';

class SetShippingAddressUsecase extends Usecase<void, CreateAddressInput> {
  final CartRepository _repository;

  SetShippingAddressUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(CreateAddressInput params) async {
    return await _repository.setShippingAddress(address: params);
  }
}
