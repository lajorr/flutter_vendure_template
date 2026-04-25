import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_item_state.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/application/providers/cart_providers.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/add_item_to_order_usecase.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/adjust_order_item_quantity_usecase.dart';

part 'cart_item_controller.g.dart';

@riverpod
class CartItemController extends _$CartItemController {
  @override
  CartItemState build() {
    return CartItemState.initial();
  }

  // ---------------------------------------------------------------------------
  // Private helper: ensure the order is in AddingItems before mutating.
  // Returns true if ready, false on transition failure.
  // ---------------------------------------------------------------------------
  Future<bool> _ensureAddingItemsState() async {
    final cartState = ref.read(cartControllerProvider);
    final activeOrderState = cartState.activeOrderState;

    if (activeOrderState == ActiveOrderStateEnum.addingItems) {
      return true;
    }

    // Currently in ArrangingPayment — transition back to AddingItems first.
    final transitioned = await ref
        .read(cartControllerProvider.notifier)
        .transitionToAddingItems();

    return transitioned;
  }

  // ---------------------------------------------------------------------------

  Future<void> addItemToOrder({
    required String variantId,
    required int quantity,
  }) async {
    state = CartItemState.loading(variantId: variantId);

    final ready = await _ensureAddingItemsState();
    if (!ready) {
      state = CartItemState.error(
        'Could not transition order to AddingItems state.',
      );
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

  Future<void> adjustLineQuantity({
    required String orderLineId,
    required int quantity,
  }) async {
    state = CartItemState.loading(orderLineId: orderLineId);

    final ready = await _ensureAddingItemsState();
    if (!ready) {
      state = CartItemState.error(
        'Could not transition order to AddingItems state.',
      );
      return;
    }

    final result = await ref
        .read(adjustOrderItemQuantityUsecaseProvider)
        .execute(
          AdjustOrderItemQuantityUsecaseParams(
            orderLineId: orderLineId,
            quantity: quantity,
          ),
        );

    result.fold(
      (failure) {
        state = CartItemState.error(failure.message);
      },
      (success) {
        state = CartItemState.success();
        ref.read(cartControllerProvider.notifier).updateActiveOrder(success);
      },
    );
  }

  Future<void> removeOrderLine({required String orderLineId}) async {
    state = CartItemState.loading(orderLineId: orderLineId);

    final ready = await _ensureAddingItemsState();
    if (!ready) {
      state = CartItemState.error(
        'Could not transition order to AddingItems state.',
      );
      return;
    }

    final result = await ref
        .read(removeOrderLineUsecaseProvider)
        .execute(orderLineId);

    result.fold(
      (failure) {
        state = CartItemState.error(failure.message);
      },
      (success) {
        state = CartItemState.success();
        ref.read(cartControllerProvider.notifier).updateActiveOrder(success);
      },
    );
  }

  Future<void> removeAllOrderLine() async {
    final ready = await _ensureAddingItemsState();
    if (!ready) {
      state = CartItemState.error(
        'Could not transition order to AddingItems state.',
      );
      return;
    }

    final result = await ref
        .read(removeAllOrderLineUsecaseProvider)
        .execute(NoParams());

    result.fold(
      (failure) {
        state = CartItemState.error(failure.message);
      },
      (success) {
        state = CartItemState.success();
        ref.read(cartControllerProvider.notifier).updateActiveOrder(success);
      },
    );
  }
}
