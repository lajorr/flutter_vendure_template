import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipping_method.freezed.dart';

@freezed
abstract class ShippingMethod with _$ShippingMethod {
  const factory ShippingMethod({
    required String id,
    required int price,
    required int priceWithTax,
    required String code,
    required String name,
    String? description,
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? customFields,
  }) = _ShippingMethod;
}
