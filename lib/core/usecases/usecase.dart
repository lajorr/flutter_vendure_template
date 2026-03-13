import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

abstract class UseCase<TypeT, Params> {
  Future<Either<Failure, TypeT>> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
