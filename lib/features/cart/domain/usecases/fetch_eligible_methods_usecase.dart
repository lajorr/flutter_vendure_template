import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/failures.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/shipping_method.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';

class FetchEligibleMethodsUsecase
    extends Usecase<List<ShippingMethod>, FetchEligibleMethodsUsecaseParams> {
  final CartRepository repository;

  FetchEligibleMethodsUsecase(this.repository);
  @override
  Future<Either<Failure, List<ShippingMethod>>> execute(
    FetchEligibleMethodsUsecaseParams params,
  ) async {
    return await repository.fetchEligibleShippingMethods(
      vendureToken: params.vendureToken,
    );
  }
}

class FetchEligibleMethodsUsecaseParams {
  final String vendureToken;

  FetchEligibleMethodsUsecaseParams({required this.vendureToken});
}
