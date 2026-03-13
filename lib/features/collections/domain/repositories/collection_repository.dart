import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/collection.dart';

abstract class CollectionRepository {
  Future<Either<Failure, List<Collection>>> getCollections({int take, int skip});
}
