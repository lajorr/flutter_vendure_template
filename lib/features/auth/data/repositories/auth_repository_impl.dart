import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/repository_exception_handler.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_input.dart';
import '../models/register_customer_input.dart';

class AuthRepositoryImpl
    with RepositoryExceptionMixin
    implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, Customer?>> getActiveCustomer() async {
    return exceptionHandler(() async {
      final model = await _remoteDataSource.getActiveCustomer();
      return model?.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> login({
    required String username,
    required String password,
  }) async {
    return exceptionHandler(() async {
      await _remoteDataSource.login(
        loginInput: LoginInput(username: username, password: password),
      );
    });
  }

  @override
  Future<Either<Failure, void>> register({
    String? title,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    required String emailAddress,
    required String password,
  }) async {
    return exceptionHandler(() async {
      await _remoteDataSource.registerCustomerAccount(
        customerInput: RegisterCustomerInput(
          title: title,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          emailAddress: emailAddress,
          password: password,
        ),
      );
    });
  }
}
