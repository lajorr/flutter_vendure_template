import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_address.freezed.dart';
part 'customer_address.g.dart';

@freezed
abstract class CustomerAddress with _$CustomerAddress {
  const factory CustomerAddress({
    required String id,
    String? fullName,
    String? company,
    String? streetLine1,
    String? streetLine2,
    String? city,
    String? province,
    String? postalCode,
    String? phoneNumber,
    required bool defaultShippingAddress,
    required bool defaultBillingAddress,
    Map<String, dynamic>? customFields,
    required Country country,
  }) = _CustomerAddress;

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressFromJson(json);
}

@freezed
abstract class Country with _$Country {
  const factory Country({
    required String id,
    required String code,
    required String name,
    Map<String, dynamic>? customFields,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
