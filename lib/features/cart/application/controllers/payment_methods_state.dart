import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/payment_method.dart';

part 'payment_methods_state.freezed.dart';

@freezed
class PaymentMethodsState with _$PaymentMethodsState {
  const factory PaymentMethodsState.initial() = _Initial;
  const factory PaymentMethodsState.loading() = _Loading;
  const factory PaymentMethodsState.success({
    required List<PaymentMethod> methods,
    PaymentMethod? selectedPaymentMethod,
  }) = _Success;
  const factory PaymentMethodsState.error(String message) = _Error;
}

extension PaymentMethodsStateExt on PaymentMethodsState {
  List<PaymentMethod> get paymentMethods =>
      maybeWhen(success: (methods, _) => methods, orElse: () => []);

  PaymentMethod? get selectedPaymentMethod =>
      maybeWhen(success: (_, selected) => selected, orElse: () => null);
}
