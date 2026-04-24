import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/errors/repository_exception_handler.dart';
import 'package:vendure_flutter_app/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:vendure_flutter_app/features/customer/domain/entities/customer_address.dart';
import 'package:vendure_flutter_app/features/customer/domain/repositories/customer_repository.dart';

final class CustomerRepositoryImpl
    with RepositoryExceptionMixin
    implements CustomerRepository {
  final CustomerRemoteDataSource _customerRemoteDataSource;

  CustomerRepositoryImpl(this._customerRemoteDataSource);
  @override
  Future<Either<Failure, List<CustomerAddress>>> getCustomerAddresses() {
    return exceptionHandler(() async {
      final addressModels = await _customerRemoteDataSource
          .fetchCustomerAddresses();
      return addressModels.map((model) => model.toEntity()).toList();
    });
  }
}
