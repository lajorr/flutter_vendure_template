import '../../../../core/network/graphql_service.dart';
import '../graphql/collection_queries.dart';
import '../models/collection_model.dart';
import 'package:logger/logger.dart';

abstract class CollectionRemoteDataSource {
  Future<List<CollectionModel>> getCollections({int take = 10, int skip = 0});
}

final _logger = Logger();

class CollectionRemoteDataSourceImpl implements CollectionRemoteDataSource {
  final GraphQLService _graphqlService;

  CollectionRemoteDataSourceImpl(this._graphqlService);

  @override
  Future<List<CollectionModel>> getCollections({int take = 10, int skip = 0}) async {
    _logger.d('CollectionRemoteDataSourceImpl: fetching collections');
    final data = await _graphqlService.performQuery(
      CollectionQueries.getCollections,
      variables: {
        'options': {'take': take, 'skip': skip}
      },
    );

    final items = data?['collections']?['items'] as List<dynamic>?;
    if (items == null) return [];

    return items
        .map((json) => CollectionModel.fromVendureJson(json as Map<String, dynamic>))
        .toList();
  }
}
