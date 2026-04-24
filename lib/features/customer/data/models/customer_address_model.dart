import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vendure_flutter_app/features/customer/domain/entities/customer_address.dart';

part 'customer_address_model.freezed.dart';
part 'customer_address_model.g.dart';

@freezed
abstract class CustomerAddressModel with _$CustomerAddressModel {
  const CustomerAddressModel._();
  const factory CustomerAddressModel({
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
    required CountryModel country,
  }) = _CustomerAddressModel;

  factory CustomerAddressModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressModelFromJson(json);

  CustomerAddress toEntity() {
    return CustomerAddress(
      id: id,
      defaultShippingAddress: defaultShippingAddress,
      defaultBillingAddress: defaultBillingAddress,
      country: country.toEntity(),
    );
  }
}

@freezed
abstract class CountryModel with _$CountryModel {
  const CountryModel._();
  const factory CountryModel({
    required String id,
    required String code,
    required String name,
    Map<String, dynamic>? customFields,
  }) = _CountryModel;

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Country toEntity() {
    return Country(id: id, code: code, name: name);
  }
}
