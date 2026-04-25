import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/payment_method.dart';

part 'payment_method_model.freezed.dart';
part 'payment_method_model.g.dart';

@freezed
abstract class PaymentMethodModel with _$PaymentMethodModel {
  const PaymentMethodModel._();
  const factory PaymentMethodModel({
    required String id,
    required String code,
    required String name,
    String? description,
    required bool isEligible,
    String? eligibilityMessage,
    Map<String, dynamic>? customFields,
  }) = _PaymentMethodModel;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);

  PaymentMethod toEntity() {
    return PaymentMethod(
      id: id,
      code: code,
      name: name,
      description: description,
      isEligible: isEligible,
      eligibilityMessage: eligibilityMessage,
      customFields: customFields,
    );
  }
}
