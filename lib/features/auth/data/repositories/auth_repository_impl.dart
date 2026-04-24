import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/repository_exception_handler.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

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
}
