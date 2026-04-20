import 'package:vendure_flutter_app/core/errors/exceptions.dart';
import 'package:vendure_flutter_app/features/cart/data/graphql/cart_mutations.dart';
import 'package:vendure_flutter_app/features/cart/data/models/add_item_to_order_request.dart';
import 'package:vendure_flutter_app/features/cart/data/models/adjust_order_line_request.dart';

import '../../../../core/network/graphql_service.dart';
import '../graphql/cart_queries.dart';
import '../models/active_order_model.dart';

abstract class CartRemoteDataSource {
  Future<ActiveOrderResponseModel> fetchActiveOrder();
  Future<void> addItemToOrder({required AddItemToOrderRequest request});
  Future<ActiveOrderModel> adjustOrderLine({
    required AdjustOrderLineRequest orderLineRequest,
  });
  Future<ActiveOrderModel> removeOrderLine({required String orderLineId});
  Future<ActiveOrderModel> removeAllOrderLine();
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
  Future<void> addItemToOrder({required AddItemToOrderRequest request}) async {
    final data = await _graphqlService.performMutation(
      CartMutations.addItemToOrderMutation,
      variables: request.toJson(),
      operationName: 'AddItemToOrder',
    );

    if (data == null) {
      throw ServerException("No Data Found");
    }
  }

  @override
  Future<ActiveOrderModel> adjustOrderLine({
    required AdjustOrderLineRequest orderLineRequest,
  }) async {
    final data = await _graphqlService.performMutation(
      CartMutations.adjustOrderLineMutation,
      variables: orderLineRequest.toJson(),
      operationName: 'AdjustOrderLine',
    );

    final result = data["adjustOrderLine"];
    if (result == null) {
      throw ServerException("No Data Found");
    }

    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return ActiveOrderModel.fromJson(result);
      case "OrderModificationError":
        throw ServerException(result["message"]);
      case "InsufficientStockError":
        throw InsufficientStockException();
      case "OrderInterceptorError":
        throw OrderInterceptorException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }

  @override
  Future<ActiveOrderModel> removeOrderLine({
    required String orderLineId,
  }) async {
    final data = await _graphqlService.performMutation(
      CartMutations.removeOrderLineMutation,
      variables: {"orderLineId": orderLineId},
      operationName: 'RemoveOrderLine',
    );

    final result = data["removeOrderLine"];
    if (result == null) {
      throw ServerException("No Data Found");
    }

    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return ActiveOrderModel.fromJson(result);
      case "OrderModificationError":
        throw ServerException(result["message"]);
      case "OrderInterceptorError":
        throw OrderInterceptorException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }

  @override
  Future<ActiveOrderModel> removeAllOrderLine() async {
    final data = await _graphqlService.performMutation(
      CartMutations.removeAllOrderLineMutation,
      operationName: 'RemoveAllOrderLines',
    );

    final result = data["removeAllOrderLines"];
    if (result == null) {
      throw ServerException("No Data Found");
    }

    final typename = result["__typename"];
    switch (typename) {
      case "Order":
        return ActiveOrderModel.fromJson(result);
      case "OrderModificationError":
        throw ServerException(result["message"]);
      case "OrderInterceptorError":
        throw OrderInterceptorException(result["message"]);
      default:
        throw ServerException("Unexpected Error");
    }
  }
}
