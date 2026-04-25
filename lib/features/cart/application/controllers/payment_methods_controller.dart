import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_state.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/payment_method.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/add_payment_to_order_usecase.dart';

import '../providers/cart_providers.dart';
import 'cart_controller.dart';
import 'payment_methods_state.dart';

part 'payment_methods_controller.g.dart';

@riverpod
class PaymentMethodsController extends _$PaymentMethodsController {
  @override
  PaymentMethodsState build() {
    return const PaymentMethodsState.initial();
  }

  Future<void> fetchEligiblePaymentMethods() async {
    state = const PaymentMethodsState.loading();

    final result = await ref
        .read(fetchEligiblePaymentMethodsUsecaseProvider)
        .execute(NoParams());

    result.fold(
      (failure) {
        state = PaymentMethodsState.error(failure.message);
      },
      (success) {
        state = PaymentMethodsState.success(
          methods: success,
          selectedPaymentMethod: null, // Initially none selected
        );
      },
    );
  }

  void selectPaymentMethod(PaymentMethod method) {
    state.whenOrNull(
      success: (methods, _) {
        state = PaymentMethodsState.success(
          methods: methods,
          selectedPaymentMethod: method,
        );
      },
    );
  }

  Future<bool> addPaymentToOrder() async {
    final selectedMethod = state.selectedPaymentMethod;

    if (selectedMethod == null) {
      state = const PaymentMethodsState.error("Please select a payment method");
      return false;
    }

    // Check the current order state. It must be 'ArrangingPayment' to add payment.
    final cartState = ref.read(cartControllerProvider);
    final currentOrderState = cartState.maybeWhen(
      success: (order) => order?.state,
      orElse: () => null,
    );

    if (currentOrderState == 'AddingItems') {
      // Transition to 'ArrangingPayment' first.
      final transitionSuccess = await ref
          .read(cartControllerProvider.notifier)
          .transitionToArrangingPayment();

      if (!transitionSuccess) {
        state = const PaymentMethodsState.error(
          "Failed to transition order state",
        );
        return false;
      }
    }

    final input = AddPaymentToOrderUsecaseParams(method: selectedMethod.code);

    final result = await ref
        .read(addPaymentToOrderUsecaseProvider)
        .execute(input);

    return result.fold(
      (failure) {
        state = PaymentMethodsState.error(failure.message);
        return false;
      },
      (_) {
        // Success
        return true;
      },
    );
  }
}
