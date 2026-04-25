import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

class TransitionOrderToStateUsecase
    extends Usecase<void, String> {
  final CartRepository _repository;

  TransitionOrderToStateUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String state) {
    return _repository.transitionOrderToState(state);
  }
}
