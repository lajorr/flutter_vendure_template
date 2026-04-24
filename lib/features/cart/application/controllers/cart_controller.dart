import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/application/providers/cart_providers.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/active_order.dart';

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


  void updateActiveOrder(ActiveOrder updatedActiveOrder) {
    state = CartState.success(activeOrder: updatedActiveOrder);
  }
}
