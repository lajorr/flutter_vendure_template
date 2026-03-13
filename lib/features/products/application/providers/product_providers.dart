import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/graphql_client.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_product_details_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';

part 'product_providers.g.dart';

@riverpod
ProductRemoteDataSource productRemoteDataSource(Ref ref) {
  final graphqlService = ref.watch(graphqlServiceProvider);
  return ProductRemoteDataSourceImpl(graphqlService);
}

@riverpod
ProductRepository productRepository(Ref ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource);
}

@riverpod
GetProductsUseCase getProductsUseCase(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductsUseCase(repository);
}

@riverpod
GetProductDetailsUseCase getProductDetailsUseCase(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductDetailsUseCase(repository);
}
