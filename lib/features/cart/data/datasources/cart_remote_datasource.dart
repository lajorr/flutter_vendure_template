import 'package:vendure_flutter_app/core/errors/exceptions.dart';
import 'package:vendure_flutter_app/features/cart/data/graphql/cart_mutations.dart';
import 'package:vendure_flutter_app/features/cart/data/models/eligible_shipping_methods.dart';

import '../../../../core/network/graphql_service.dart';
import '../graphql/cart_queries.dart';
import '../models/active_order_model.dart';

abstract class CartRemoteDataSource {
  Future<ActiveOrderResponseModel> fetchActiveOrder();
  Future<EligibleShippingMethodsResponse> fetchEligibleShippingMethods({
    String? vendureToken,
  });
  Future<void> setOrderShippingMethod(String shippingMethodId);
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
}
