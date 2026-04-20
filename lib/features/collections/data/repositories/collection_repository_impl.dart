import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/repository_exception_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/collection.dart';
import '../../domain/repositories/collection_repository.dart';
import '../datasources/collection_remote_datasource.dart';

class CollectionRepositoryImpl with RepositoryExceptionMixin implements CollectionRepository {
  final CollectionRemoteDataSource _remoteDataSource;

  CollectionRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Collection>>> getCollections({
    int take = 10,
    int skip = 0,
  }) async {
    return exceptionHandler(() async {
      final models =
          await _remoteDataSource.getCollections(take: take, skip: skip);
      return models.map((m) => m.toEntity()).toList();
    });
  }
}
