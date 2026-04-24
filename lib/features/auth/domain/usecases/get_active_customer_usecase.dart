import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/auth/domain/entities/customer.dart';
import 'package:vendure_flutter_app/features/auth/domain/repositories/auth_repository.dart';

class GetActiveCustomerUsecase extends Usecase<Customer?, NoParams> {
  final AuthRepository _authRepository;

  GetActiveCustomerUsecase(this._authRepository);
  @override
  Future<Either<Failure, Customer?>> execute(NoParams params) async {
    return await _authRepository.getActiveCustomer();
  }
}
