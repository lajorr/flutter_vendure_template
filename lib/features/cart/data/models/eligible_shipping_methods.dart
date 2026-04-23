import 'package:freezed_annotation/freezed_annotation.dart';

part 'eligible_shipping_methods.freezed.dart';
part 'eligible_shipping_methods.g.dart';

@freezed
abstract class EligibleShippingMethodsResponse
    with _$EligibleShippingMethodsResponse {
  const factory EligibleShippingMethodsResponse({
    required List<ShippingMethodModel> eligibleShippingMethods,
  }) = _EligibleShippingMethodsResponse;

  factory EligibleShippingMethodsResponse.fromJson(Map<String, dynamic> json) =>
      _$EligibleShippingMethodsResponseFromJson(json);
}

@freezed
abstract class ShippingMethodModel with _$ShippingMethodModel {
  const factory ShippingMethodModel({
    required String id,
    required int price,
    required int priceWithTax,
    required String code,
    required String name,
    String? description,
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? customFields,
  }) = _ShippingMethodModel;

  factory ShippingMethodModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodModelFromJson(json);
}
