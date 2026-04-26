import 'package:dartz/dartz.dart';
import 'exceptions.dart';
import 'failures.dart';

mixin RepositoryExceptionMixin {
  Future<Either<Failure, T>> exceptionHandler<T>(
    Future<T> Function() call,
  ) async {
    try {
      return Right(await call());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AccountNotVerifiedException catch (e) {
      return Left(AccountNotVerifiedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AppTimeoutException catch (e) {
      return Left(TimeoutFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
