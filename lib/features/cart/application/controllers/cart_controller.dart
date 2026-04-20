import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_item_state.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/application/providers/cart_providers.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/add_item_to_order_usecase.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  @override
  CartState build() {
    return CartState.initial();
  }

  Future<void> fetchActiveOrder() async {
    state = const CartState.loading();

    final result = await ref
        .read(fetchActiveOrderUsecaseProvider)
        .execute(NoParams());

    result.fold(
      (failure) {
        state = CartState.error(failure.message);
      },
      (success) {
        state = CartState.success(activeOrder: success);
      },
    );
  }
}

@riverpod
class CartItemController extends _$CartItemController {
  @override
  CartItemState build() {
    return CartItemState.initial();
  }

  Future<void> addItemToOrder({
    required String variantId,
    required int quantity,
  }) async {
    final cartState = ref.read(cartControllerProvider);
    final activeOrderState = cartState.activeOrderState;

    state = CartItemState.loading(variantId);

    if (activeOrderState != ActiveOrderStateEnum.addingItems) {
      // TODO: transition to adding items
      state = CartItemState.error("Arranging payment statte");
      return;
    }

    final result = await ref
        .read(addItemToOrderUsecaseProvider)
        .execute(
          AddItemToOrderUseCaseParams(variantId: variantId, quantity: quantity),
        );

    result.fold(
      (failure) {
        state = CartItemState.error(failure.message);
      },
      (success) {
        state = CartItemState.success();
        ref.read(cartControllerProvider.notifier).fetchActiveOrder();
      },
    );
  }
}
