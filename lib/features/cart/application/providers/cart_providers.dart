import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/network/graphql_client.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:vendure_flutter_app/features/cart/data/datasources/order_line_remote_datasource.dart';
import 'package:vendure_flutter_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:vendure_flutter_app/features/cart/data/repositories/order_line_repository_impl.dart';
import 'package:vendure_flutter_app/features/auth/domain/entities/customer.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';
import 'package:vendure_flutter_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/add_item_to_order_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/adjust_order_item_quantity_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/fetch_active_order_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/fetch_eligible_methods_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/fetch_eligible_payment_methods_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/remove_all_order_line_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/remove_order_line_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/set_billing_address_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/set_shipping_address_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/set_shipping_method_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/transition_order_to_state_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/add_payment_to_order_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/set_customer_for_order_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/unset_order_shipping_address_usecase.dart';

part 'cart_providers.g.dart';

@riverpod
ActiveOrderAddress? shippingAddress(Ref ref) {
  return ref.watch(cartControllerProvider).maybeWhen(
    success: (activeOrder) => activeOrder?.shippingAddress,
    orElse: () => null,
  );
}

@riverpod
Customer? customer(Ref ref) {
  return ref.watch(cartControllerProvider).customer;
}

@riverpod
CartRemoteDataSource cartRemoteDatasource(Ref ref) {
  final graphqlService = ref.watch(graphqlServiceProvider);
  return CartRemoteDataSourceImpl(graphqlService);
}

@riverpod
OrderLineRemoteDatasource orderLineRemoteDatasource(Ref ref) {
  final graphqlService = ref.watch(graphqlServiceProvider);
  return OrderLineRemoteDatasourceImpl(graphqlService);
}

@riverpod
CartRepository cartRepository(Ref ref) {
  final cartRemoteDatasource = ref.read(cartRemoteDatasourceProvider);

  return CartRepositoryImpl(cartRemoteDatasource);
}

@riverpod
OrderLineRepository orderLineRepository(Ref ref) {
  final orderLineDatasource = ref.read(orderLineRemoteDatasourceProvider);

  return OrderLineRepositoryImpl(orderLineDatasource);
}

@riverpod
FetchActiveOrderUseCase fetchActiveOrderUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return FetchActiveOrderUseCase(repository);
}

@riverpod
AddItemToOrderUseCase addItemToOrderUsecase(Ref ref) {
  final repository = ref.watch(orderLineRepositoryProvider);
  return AddItemToOrderUseCase(repository);
}

@riverpod
AdjustOrderItemQuantityUsecase adjustOrderItemQuantityUsecase(Ref ref) {
  final repository = ref.watch(orderLineRepositoryProvider);
  return AdjustOrderItemQuantityUsecase(repository);
}

@riverpod
FetchEligibleMethodsUsecase fetchEligibleMethodsUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return FetchEligibleMethodsUsecase(repository);
}

@riverpod
FetchEligiblePaymentMethodsUsecase fetchEligiblePaymentMethodsUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return FetchEligiblePaymentMethodsUsecase(repository);
}

@riverpod
RemoveOrderLineUsecase removeOrderLineUsecase(Ref ref) {
  final repository = ref.watch(orderLineRepositoryProvider);
  return RemoveOrderLineUsecase(repository);
}

@riverpod
RemoveAllOrderLineUsecase removeAllOrderLineUsecase(Ref ref) {
  final repository = ref.watch(orderLineRepositoryProvider);
  return RemoveAllOrderLineUsecase(repository);
}

@riverpod
SetShippingMethodUsecase setShippingMethodUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return SetShippingMethodUsecase(repository);
}

@riverpod
SetShippingAddressUsecase setShippingAddressUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return SetShippingAddressUsecase(repository);
}

@riverpod
SetBillingAddressUsecase setBillingAddressUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return SetBillingAddressUsecase(repository);
}

@riverpod
TransitionOrderToStateUsecase transitionOrderToStateUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return TransitionOrderToStateUsecase(repository);
}

@riverpod
AddPaymentToOrderUsecase addPaymentToOrderUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return AddPaymentToOrderUsecase(repository);
}

@riverpod
SetCustomerForOrderUseCase setCustomerForOrderUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return SetCustomerForOrderUseCase(repository);
}

@riverpod
UnsetOrderShippingAddressUseCase unsetOrderShippingAddressUsecase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return UnsetOrderShippingAddressUseCase(repository);
}
