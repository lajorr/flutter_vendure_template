import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_address_input.freezed.dart';
part 'create_address_input.g.dart';

@Freezed(toJson: true)
abstract class CreateAddressInput with _$CreateAddressInput {
  const factory CreateAddressInput({
    String? fullName,
    String? company,
    required String streetLine1,
    String? streetLine2,
    String? city,
    String? province,
    String? postalCode,
    required String countryCode,
    String? phoneNumber,
    bool? defaultShippingAddress,
    bool? defaultBillingAddress,
    Map<String, dynamic>? customFields,
  }) = _CreateAddressInput;
}
