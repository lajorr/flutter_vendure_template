import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/customer.dart';

abstract class AuthRepository {
  Future<Either<Failure, Customer?>> getActiveCustomer();
}
