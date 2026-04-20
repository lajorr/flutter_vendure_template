import 'package:vendure_flutter_app/core/errors/exceptions.dart';
import 'package:vendure_flutter_app/features/cart/data/graphql/cart_mutations.dart';
import 'package:vendure_flutter_app/features/cart/data/models/add_item_to_order_request.dart';

import '../../../../core/network/graphql_service.dart';
import '../graphql/cart_queries.dart';
import '../models/active_order_model.dart';

abstract class CartRemoteDataSource {
  Future<ActiveOrderResponseModel> fetchActiveOrder();
  Future<void> addItemToOrder({required AddItemToOrderRequest request});
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
}
