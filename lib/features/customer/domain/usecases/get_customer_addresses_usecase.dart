import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/customer/domain/entities/customer_address.dart';
import 'package:vendure_flutter_app/features/customer/domain/repositories/customer_repository.dart';

class GetCustomerAddressesUsecase
    extends Usecase<List<CustomerAddress>, NoParams> {
  final CustomerRepository repository;

  GetCustomerAddressesUsecase(this.repository);

  @override
  Future<Either<Failure, List<CustomerAddress>>> execute(
    NoParams params,
  ) async {
    return await repository.getCustomerAddresses();
  }
}
