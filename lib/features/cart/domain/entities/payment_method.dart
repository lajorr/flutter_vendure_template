import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method.freezed.dart';

@freezed
abstract class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String id,
    required String code,
    required String name,
    String? description,
    required bool isEligible,
    String? eligibilityMessage,
    Map<String, dynamic>? customFields,
  }) = _PaymentMethod;
}
