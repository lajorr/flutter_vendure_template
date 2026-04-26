import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/customer.dart';

abstract class AuthRepository {
  Future<Either<Failure, Customer?>> getActiveCustomer();

  Future<Either<Failure, void>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, void>> register({
    String? title,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    required String emailAddress,
    required String password,
  });
}
