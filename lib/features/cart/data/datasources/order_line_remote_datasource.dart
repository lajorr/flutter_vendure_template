import 'package:vendure_flutter_app/core/errors/exceptions.dart';
import 'package:vendure_flutter_app/core/network/graphql_service.dart';
import 'package:vendure_flutter_app/features/cart/data/graphql/cart_mutations.dart';
import 'package:vendure_flutter_app/features/cart/data/models/active_order_model.dart';
import 'package:vendure_flutter_app/features/cart/data/models/add_item_to_order_request.dart';
import 'package:vendure_flutter_app/features/cart/data/models/adjust_order_line_request.dart';

abstract class OrderLineRemoteDatasource {
  Future<void> addItemToOrder({required AddItemToOrderRequest request});
  Future<ActiveOrderModel> adjustOrderLine({
    required AdjustOrderLineRequest orderLineRequest,
  });
  Future<ActiveOrderModel> removeOrderLine({required String orderLineId});
  Future<ActiveOrderModel> removeAllOrderLine();
}

final class OrderLineRemoteDatasourceImpl implements OrderLineRemoteDatasource {
  final GraphQLService _graphqlService;

  OrderLineRemoteDatasourceImpl(this._graphqlService);

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
