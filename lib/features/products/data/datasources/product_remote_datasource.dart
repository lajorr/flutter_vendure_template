import 'package:logger/logger.dart';

import '../../../../core/network/graphql_service.dart';
import '../graphql/product_queries.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int take = 10, int skip = 0});
  Future<ProductModel> getProductDetails(String slug);
}

final _logger = Logger();

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final GraphQLService _graphqlService;

  ProductRemoteDataSourceImpl(this._graphqlService);

  @override
  Future<List<ProductModel>> getProducts({int take = 10, int skip = 0}) async {
    _logger.d(
      'ProductRemoteDataSourceImpl: fetching products with take=$take skip=$skip',
    );
    final data = await _graphqlService.performQuery(
      ProductQueries.getProducts,
      variables: {'take': take, 'skip': skip},
    );

    final items = data?['products']?['items'] as List<dynamic>?;
    if (items == null) {
      _logger.w(
        'ProductRemoteDataSourceImpl: No items found in response payload.',
      );
      return [];
    }

    try {
      final models = items
          .map(
            (json) =>
                ProductModel.fromVendureJson(json as Map<String, dynamic>),
          )
          .toList();
      _logger.d(
        'ProductRemoteDataSourceImpl: Successfully parsed ${models.length} products',
      );
      return models;
    } catch (e, st) {
      _logger.e(
        'ProductRemoteDataSourceImpl: Failed to parse products from json',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductDetails(String slug) async {
    final data = await _graphqlService.performQuery(
      ProductQueries.getProductDetails,
      variables: {'slug': slug},
    );

    final productData = data?['product'];
    if (productData == null) {
      throw Exception('Product not found');
    }

    return ProductModel.fromVendureJson(productData as Map<String, dynamic>);
  }
}
