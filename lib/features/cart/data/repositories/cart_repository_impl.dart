import 'package:dartz/dartz.dart';
import 'package:vendure_flutter_app/core/errors/repository_exception_handler.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/payment_method.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/shipping_method.dart';
import 'package:vendure_flutter_app/shared/models/create_address_input.dart';
import 'package:vendure_flutter_app/shared/models/create_customer_input.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/active_order.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';
import '../models/payment_input.dart';

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

  @override
  Future<Either<Failure, void>> setBillingAddress({
    required CreateAddressInput address,
  }) {
    return exceptionHandler(() async {
      await _cartRemoteDatasource.setOrderBillingAddress(address);
    });
  }

  @override
  Future<Either<Failure, void>> setShippingAddress({
    required CreateAddressInput address,
  }) {
    return exceptionHandler(() async {
      await _cartRemoteDatasource.setOrderShippingAddress(address);
    });
  }

  @override
  Future<Either<Failure, List<PaymentMethod>>> fetchEligiblePaymentMethods() {
    return exceptionHandler(() async {
      final paymentModels = await _cartRemoteDatasource
          .fetchEligiblePaymentMethods();
      return paymentModels.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> transitionOrderToState(String state) {
    return exceptionHandler(() async {
      await _cartRemoteDatasource.transitionOrderToState(state);
    });
  }

  @override
  Future<Either<Failure, void>> addPaymentToOrder({
    required String method,
    Map<String, dynamic>? metadata,
  }) {
    return exceptionHandler(() async {
      return await _cartRemoteDatasource.addPaymentToOrder(
        PaymentInput(method: method, metadata: metadata ?? {}),
      );
    });
  }

  @override
  Future<Either<Failure, ActiveOrder>> setCustomerForOrder({
    required CreateCustomerInput customerInput,
  }) {
    return exceptionHandler(() async {
      final orderModel = await _cartRemoteDatasource.setCustomerForOrder(
        customerInput,
      );
      return orderModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, ActiveOrder>> unsetOrderShippingAddress() {
    return exceptionHandler(() async {
      final orderModel = await _cartRemoteDatasource
          .unsetOrderShippingAddress();
      return orderModel.toEntity();
    });
  }
}
