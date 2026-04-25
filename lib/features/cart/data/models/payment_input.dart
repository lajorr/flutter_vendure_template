import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_input.freezed.dart';
part 'payment_input.g.dart';

@Freezed(toJson: true)
abstract class PaymentInput with _$PaymentInput {
  const factory PaymentInput({
    required String method,
    @Default({}) Map<String, dynamic> metadata,
  }) = _PaymentInput;
}
