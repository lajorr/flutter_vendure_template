import 'package:vendure_flutter_app/core/errors/exceptions.dart';
import 'package:vendure_flutter_app/core/extensions/map_ext.dart';
import 'package:vendure_flutter_app/features/cart/data/graphql/cart_mutations.dart';
import 'package:vendure_flutter_app/features/cart/data/models/eligible_shipping_methods.dart';
import 'package:vendure_flutter_app/features/cart/data/models/payment_method_model.dart';
import 'package:vendure_flutter_app/shared/models/create_address_input.dart';
import 'package:vendure_flutter_app/shared/models/create_customer_input.dart';

import '../../../../core/network/graphql_service.dart';
import '../graphql/cart_queries.dart';
import '../models/active_order_model.dart';
import '../models/payment_input.dart';

abstract class CartRemoteDataSource {
  Future<ActiveOrderResponseModel> fetchActiveOrder();
  Future<EligibleShippingMethodsResponse> fetchEligibleShippingMethods({
    String? vendureToken,
  });
  Future<List<PaymentMethodModel>> fetchEligiblePaymentMethods();
  Future<void> setOrderShippingMethod(String shippingMethodId);
  Future<ActiveOrderModel> unsetOrderShippingAddress();
  Future<void> setOrderShippingAddress(CreateAddressInput addressInput);
  Future<void> setOrderBillingAddress(CreateAddressInput addressInput);
  Future<void> transitionOrderToState(String state);

  Future<void> addPaymentToOrder(PaymentInput input);

  Future<ActiveOrderModel> setCustomerForOrder(
    CreateCustomerInput customerInput,
  );
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final GraphQLService _graphqlService;

  CartRemoteDataSourceImpl(this._graphqlService);

  @override
  Future<ActiveOrderResponseModel> fetchActiveOrder() async {
    final data = await _graphqlService.performQuery(
      CartQueries.activeOrderQuery,
      operationName: 'ActiveOrder',
    );

    if (data == null) {
      throw ServerException("No Data Found");
    }
    if (data is Map<String, dynamic>) {
      return ActiveOrderResponseModel.fromJson(data);
    }
    throw ServerException("Invalid Data Format");
  }

  @override
  Future<EligibleShippingMethodsResponse> fetchEligibleShippingMethods({
    String? vendureToken,
  }) async {
    final data = await _graphqlService.performQuery(
      CartQueries.eligibleShippingMethodsQuery,
      operationName: 'EligibleShippingMethods',
    );
    if (data == null) {
      throw ServerException("No Data Found");
    }
    if (data is Map<String, dynamic>) {
      return EligibleShippingMethodsResponse.fromJson(data);
    }
    throw ServerException("Invalid Data Format");
  }

  @override
  Future<void> setOrderShippingMethod(String shippingMethodId) async {
    final data = await _graphqlService.performMutation(
      CartMutations.setOrderShippingMethodMutation,
      operationName: 'SetOrderShippingMethod',
      variables: {
        "shippingMethodId": [shippingMethodId],
      },
    );

    final result = data["setOrderShippingMethod"];
    if (result == null) {
      throw ServerException("No Data Found");
    }
    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return;
      case "OrderModificationError":
        throw ServerException(result["message"]);
      case "IneligibleShippingMethodError":
        throw ServerException(result["message"]);
      case "NoActiveOrderError":
        throw ServerException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }

  @override
  Future<void> setOrderBillingAddress(CreateAddressInput addressInput) async {
    final input = addressInput.toJson().withoutNulls;

    final data = await _graphqlService.performMutation(
      CartMutations.setOrderBillingAddressMutation,
      operationName: 'SetOrderBillingAddress',
      variables: {"input": input},
    );

    final result = data["setOrderBillingAddress"];
    if (result == null) {
      throw ServerException("No Data Found");
    }
    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return;
      case "NoActiveOrderError":
        throw ServerException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }

  @override
  Future<void> setOrderShippingAddress(CreateAddressInput addressInput) async {
    final input = addressInput.toJson().withoutNulls;

    final data = await _graphqlService.performMutation(
      CartMutations.setOrderShippingAddressMutation,
      operationName: 'SetOrderShippingAddress',
      variables: {"input": input},
    );

    final result = data["setOrderShippingAddress"];
    if (result == null) {
      throw ServerException("No Data Found");
    }
    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return;
      case "NoActiveOrderError":
        throw ServerException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }

  @override
  Future<List<PaymentMethodModel>> fetchEligiblePaymentMethods() async {
    final data = await _graphqlService.performQuery(
      CartQueries.eligiblePaymentMethodsQuery,
      operationName: 'EligiblePaymentMethods',
    );
    final paymentMethods = data["eligiblePaymentMethods"];
    if (paymentMethods == null) {
      throw ServerException("No Data Found");
    }
    if (paymentMethods is List<dynamic>) {
      return paymentMethods
          .map((method) => PaymentMethodModel.fromJson(method))
          .toList();
    }
    throw ServerException("Invalid Data Format");
  }

  @override
  Future<void> transitionOrderToState(String state) async {
    final data = await _graphqlService.performMutation(
      CartMutations.transitionOrderToStateMutation,
      operationName: 'TransitionOrderToState',
      variables: {"state": state},
    );

    final result = data["transitionOrderToState"];
    if (result == null) {
      throw ServerException("No Data Found");
    }
    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return;
      case "OrderStateTransitionError":
        throw ServerException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }

  @override
  Future<void> addPaymentToOrder(PaymentInput paymentInput) async {
    final data = await _graphqlService.performMutation(
      CartMutations.addPaymentToOrder,
      operationName: 'AddPaymentToOrder',
      variables: {"input": paymentInput.toJson()},
    );

    final result = data["addPaymentToOrder"];
    if (result == null) {
      throw ServerException("No Data Found");
    }
    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return;
      case "OrderPaymentStateError":
      case "IneligiblePaymentMethodError":
      case "PaymentFailedError":
      case "PaymentDeclinedError":
      case "OrderStateTransitionError":
      case "NoActiveOrderError":
        throw ServerException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }

  @override
  Future<ActiveOrderModel> setCustomerForOrder(
    CreateCustomerInput customerInput,
  ) async {
    final data = await _graphqlService.performMutation(
      CartMutations.setCustomerForOrderMutation,
      operationName: 'SetCustomerForOrder',
      variables: {"input": customerInput.toJson().withoutNulls},
    );

    final result = data["setCustomerForOrder"];
    if (result == null) {
      throw ServerException("No Data Found");
    }
    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return ActiveOrderModel.fromJson(result);
      case "OrderPaymentStateError":
      case "IneligiblePaymentMethodError":
      case "PaymentFailedError":
      case "PaymentDeclinedError":
      case "OrderStateTransitionError":
      case "NoActiveOrderError":
        throw ServerException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }

  @override
  Future<ActiveOrderModel> unsetOrderShippingAddress() async {
    final data = await _graphqlService.performMutation(
      CartMutations.unsetOrderShippingAddressMutation,
      operationName: 'UnsetOrderShippingAddress',
    );

    final result = data["unsetOrderShippingAddress"];
    if (result == null) {
      throw ServerException("No Data Found");
    }
    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return ActiveOrderModel.fromJson(result);
      case "NoActiveOrderError":
        throw ServerException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }
}
