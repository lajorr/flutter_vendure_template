import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_customer_input.freezed.dart';
part 'register_customer_input.g.dart';

@Freezed(toJson: true)
abstract class RegisterCustomerInput with _$RegisterCustomerInput {
  const factory RegisterCustomerInput({
    String? title,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    required String emailAddress,
    required String password,
    Map<String, dynamic>? customFields,
  }) = _RegisterCustomerInput;
}
