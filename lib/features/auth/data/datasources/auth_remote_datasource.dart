import 'package:logger/logger.dart';

import '../../../../core/network/graphql_service.dart';
import '../graphql/auth_queries.dart';
import '../models/customer_model.dart';

abstract class AuthRemoteDataSource {
  Future<CustomerModel?> getActiveCustomer();
}

final _logger = Logger();

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GraphQLService _graphqlService;

  AuthRemoteDataSourceImpl(this._graphqlService);

  @override
  Future<CustomerModel?> getActiveCustomer() async {
    _logger.d('AuthRemoteDataSourceImpl: fetching active customer');
    try {
      final data = await _graphqlService.performQuery(
        AuthQueries.activeCustomerQuery,
        operationName: 'ActiveCustomer',
      );

      final customerData = data?['activeCustomer'];
      if (customerData == null) {
        _logger.w('AuthRemoteDataSourceImpl: active customer is null.');
        return null;
      }

      return CustomerModel.fromJson(customerData as Map<String, dynamic>);
    } catch (e, st) {
      _logger.e(
        'AuthRemoteDataSourceImpl: Failed to fetch active customer',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
