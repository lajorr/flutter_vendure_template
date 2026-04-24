import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/network/graphql_client.dart';
import 'package:vendure_flutter_app/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:vendure_flutter_app/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:vendure_flutter_app/features/customer/domain/repositories/customer_repository.dart';
import 'package:vendure_flutter_app/features/customer/domain/usecases/get_customer_addresses_usecase.dart';

part 'customer_providers.g.dart';

@riverpod
CustomerRemoteDataSource customerRemoteDataSource(Ref ref) {
  final graphqlService = ref.watch(graphqlServiceProvider);
  return CustomerRemoteDataSourceImpl(graphqlService);
}

@riverpod
CustomerRepository customerRepository(Ref ref) {
  final datasource = ref.watch(customerRemoteDataSourceProvider);
  return CustomerRepositoryImpl(datasource);
}

@riverpod
GetCustomerAddressesUsecase getCustomerAddressesUsecase(Ref ref) {
  final repository = ref.watch(customerRepositoryProvider);
  return GetCustomerAddressesUsecase(repository);
}
