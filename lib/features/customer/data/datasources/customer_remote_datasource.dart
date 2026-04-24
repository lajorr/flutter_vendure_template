import 'package:vendure_flutter_app/core/errors/exceptions.dart';
import 'package:vendure_flutter_app/core/network/graphql_service.dart';
import 'package:vendure_flutter_app/features/customer/data/graphql/customer_queries.dart';
import 'package:vendure_flutter_app/features/customer/data/models/customer_address_model.dart';

abstract class CustomerRemoteDataSource {
  Future<List<CustomerAddressModel>> fetchCustomerAddresses();
}

class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  final GraphQLService _graphqlService;

  CustomerRemoteDataSourceImpl(this._graphqlService);

  @override
  Future<List<CustomerAddressModel>> fetchCustomerAddresses() async {
    final data = await _graphqlService.performQuery(
      CustomerQueries.customAddressesQuery,
      operationName: 'ActiveCustomer',
    );
    final activeCustomer = data['activeCustomer'];
    if (activeCustomer == null) {
      return [];
    }
    final addresses = activeCustomer["addresses"];
    if (addresses is List<dynamic>) {
      return addresses
          .map((addr) => CustomerAddressModel.fromJson(addr))
          .toList();
    }
    throw ServerException("Invalid Address Format");
  }
}
