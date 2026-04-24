import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/features/customer/domain/entities/customer_address.dart';

abstract class CustomerRepository {
  Future<Either<Failure, List<CustomerAddress>>> getCustomerAddresses();

  
}
