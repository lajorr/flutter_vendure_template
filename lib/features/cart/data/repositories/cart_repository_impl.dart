import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/repository_exception_handler.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/shipping_method.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/active_order.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';

class CartRepositoryImpl
    with RepositoryExceptionMixin
    implements CartRepository {
  final CartRemoteDataSource _cartRemoteDatasource;

  CartRepositoryImpl(this._cartRemoteDatasource);

  @override
  Future<Either<Failure, ActiveOrder?>> fetchActiveOrder() async {
    return exceptionHandler(() async {
      final response = await _cartRemoteDatasource.fetchActiveOrder();
      return response.activeOrder?.toEntity();
    });
  }

  @override
  Future<Either<Failure, List<ShippingMethod>>> fetchEligibleShippingMethods({
    String? vendureToken,
  }) {
    return exceptionHandler(() async {
      final response = await _cartRemoteDatasource.fetchEligibleShippingMethods(
        vendureToken: vendureToken,
      );
      return response.eligibleShippingMethods
          .map(
            (model) => ShippingMethod(
              id: model.id,
              price: model.price,
              priceWithTax: model.priceWithTax,
              code: model.code,
              name: model.name,
              description: model.description,
              metadata: model.metadata,
              customFields: model.customFields,
            ),
          )
          .toList();
    });
  }

  @override
  Future<Either<Failure, void>> setShippingMethod({required String methodId}) {
    return exceptionHandler(() async {
      await _cartRemoteDatasource.setOrderShippingMethod(methodId);
    });
  }
}
