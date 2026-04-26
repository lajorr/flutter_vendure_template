import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/providers/cart_providers.dart';
import 'package:vendure_flutter_app/shared/models/create_customer_input.dart';

part 'set_order_customer_controller.g.dart';

@riverpod
class SetOrderCustomerController extends _$SetOrderCustomerController {
  @override
  FutureOr<void> build() {}

  Future<void> setCustomer(CreateCustomerInput input) async {
    state = const AsyncValue.loading();

    final result = await ref
        .read(setCustomerForOrderUsecaseProvider)
        .execute(input);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (order) {
        // Update the global cart state with the updated order
        ref.read(cartControllerProvider.notifier).updateActiveOrder(order);
        state = const AsyncValue.data(null);
      },
    );
  }
}
