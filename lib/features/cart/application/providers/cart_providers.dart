import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/network/graphql_client.dart';
import 'package:vendure_flutter_app/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:vendure_flutter_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/add_item_to_order_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/adjust_order_item_quantity_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/fetch_active_order_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/remove_all_order_line_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/remove_order_line_usecase.dart';

part 'cart_providers.g.dart';

@riverpod
CartRemoteDataSource cartRemoteDatasource(Ref ref) {
  final graphqlService = ref.watch(graphqlServiceProvider);
  return CartRemoteDataSourceImpl(graphqlService);
}

@riverpod
CartRepository cartRepository(Ref ref) {
  final remoteDatasource = ref.read(cartRemoteDatasourceProvider);

  return CartRepositoryImpl(remoteDatasource);
}

@riverpod
FetchActiveOrderUseCase fetchActiveOrderUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return FetchActiveOrderUseCase(repository);
}

@riverpod
AddItemToOrderUseCase addItemToOrderUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return AddItemToOrderUseCase(repository);
}

@riverpod
AdjustOrderItemQuantityUsecase adjustOrderItemQuantityUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return AdjustOrderItemQuantityUsecase(repository);
}

@riverpod
RemoveOrderLineUsecase removeOrderLineUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return RemoveOrderLineUsecase(repository);
}

@riverpod
RemoveAllOrderLineUsecase removeAllOrderLineUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return RemoveAllOrderLineUsecase(repository);
}
