import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/providers/cart_providers.dart';
import 'package:vendure_flutter_app/shared/models/create_address_input.dart';

part 'set_order_address_controller.g.dart';

@riverpod
class SetOrderAddressController extends _$SetOrderAddressController {
  @override
  FutureOr<void> build() {}

  Future<void> setAddress(CreateAddressInput address) async {
    state = const AsyncValue.loading();

    final shippingResult = await ref
        .read(setShippingAddressUsecaseProvider)
        .execute(address);

    final billingResult = await ref
        .read(setBillingAddressUsecaseProvider)
        .execute(address);

    shippingResult.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (_) {
        billingResult.fold(
          (failure) {
            state = AsyncValue.error(failure.message, StackTrace.current);
          },
          (_) async {
            // Both succeeded, refresh active order
            await ref.read(cartControllerProvider.notifier).fetchActiveOrder();
            state = const AsyncValue.data(null);
          },
        );
      },
    );
  }
}
