import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vendure_flutter_app/features/products/domain/entities/asset.dart';

import '../../../../features/products/domain/entities/product_variant.dart';

part 'active_order.freezed.dart';

@freezed
abstract class ActiveOrderResponse with _$ActiveOrderResponse {
  const factory ActiveOrderResponse({ActiveOrder? activeOrder}) =
      _ActiveOrderResponse;
}

@freezed
abstract class ActiveOrder with _$ActiveOrder {
  const factory ActiveOrder({
    required String id,
    String? orderPlacedAt,
    required String code,
    required String state,
    required bool active,
    @Default([]) List<String> couponCodes,
    @Default(0) int totalQuantity,
    @Default(0) int subTotal,
    @Default(0) int subTotalWithTax,
    required String currencyCode,
    @Default(0) int shipping,
    @Default(0) int shippingWithTax,
    @Default(0) int total,
    @Default(0) int totalWithTax,
    dynamic customFields,
    ActiveOrderAddress? shippingAddress,
    @Default([]) List<ActiveOrderLine> lines,
    ActiveOrderAddress? billingAddress,
    @Default([]) List<ActiveOrderShippingLine> shippingLines,
    required String type,
  }) = _ActiveOrder;
}

@freezed
abstract class ActiveOrderAddress with _$ActiveOrderAddress {
  const factory ActiveOrderAddress({
    String? fullName,
    String? company,
    String? streetLine1,
    String? streetLine2,
    String? city,
    String? province,
    String? postalCode,
    String? country,
    String? countryCode,
    String? phoneNumber,
    dynamic customFields,
  }) = _ActiveOrderAddress;
}

@freezed
abstract class ActiveOrderLine with _$ActiveOrderLine {
  const factory ActiveOrderLine({
    required String id,
    @Default(0) int unitPrice,
    @Default(0) int unitPriceWithTax,
    @Default(0) int discountedUnitPrice,
    @Default(0) int quantity,
    @Default(0) int linePrice,
    @Default(0) int linePriceWithTax,
    @Default(0) int discountedLinePrice,
    dynamic customFields,
    Asset? featuredAsset,
    ProductVariant? productVariant,
  }) = _ActiveOrderLine;
}

@freezed
abstract class ActiveOrderShippingLine with _$ActiveOrderShippingLine {
  const factory ActiveOrderShippingLine({
    required String id,
    @Default(0) int price,
    @Default(0) int priceWithTax,
    @Default(0) int discountedPrice,
    @Default(0) int discountedPriceWithTax,
    dynamic customFields,
  }) = _ActiveOrderShippingLine;
}
