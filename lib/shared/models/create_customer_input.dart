import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_customer_input.freezed.dart';
part 'create_customer_input.g.dart';

@Freezed(toJson: true)
abstract class CreateCustomerInput with _$CreateCustomerInput {
  const factory CreateCustomerInput({
    String? title,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    required String emailAddress,
    Map<String, dynamic>? customFields,
  }) = _CreateCustomerInput;
}
