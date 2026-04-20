import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../features/products/data/models/asset_model.dart';
import '../../../../features/products/data/models/product_variant_model.dart';
import '../../domain/entities/active_order.dart';

part 'active_order_model.freezed.dart';
part 'active_order_model.g.dart';

@freezed
abstract class ActiveOrderModel with _$ActiveOrderModel {
  const factory ActiveOrderModel({
    @Default('') String id,
    String? orderPlacedAt,
    @Default('') String code,
    @Default('') String state,
    @Default(false) bool active,
    @Default([]) List<String> couponCodes,
    @Default(0) int totalQuantity,
    @Default(0) int subTotal,
    @Default(0) int subTotalWithTax,
    @Default('') String currencyCode,
    @Default(0) int shipping,
    @Default(0) int shippingWithTax,
    @Default(0) int total,
    @Default(0) int totalWithTax,
    dynamic customFields,
    ActiveOrderAddressModel? shippingAddress,
    @Default([]) List<ActiveOrderLineModel> lines,
    ActiveOrderAddressModel? billingAddress,
    @Default([]) List<ActiveOrderShippingLineModel> shippingLines,
    @Default('') String type,
  }) = _ActiveOrderModel;

  factory ActiveOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveOrderModelFromJson(json);

  const ActiveOrderModel._();

  ActiveOrder toEntity() => ActiveOrder(
    id: id,
    orderPlacedAt: orderPlacedAt,
    code: code,
    state: state,
    active: active,
    couponCodes: couponCodes,
    totalQuantity: totalQuantity,
    subTotal: subTotal,
    subTotalWithTax: subTotalWithTax,
    currencyCode: currencyCode,
    shipping: shipping,
    shippingWithTax: shippingWithTax,
    total: total,
    totalWithTax: totalWithTax,
    customFields: customFields,
    shippingAddress: shippingAddress?.toEntity(),
    lines: lines.map((e) => e.toEntity()).toList(),
    billingAddress: billingAddress?.toEntity(),
    shippingLines: shippingLines.map((e) => e.toEntity()).toList(),
    type: type,
  );
}

@freezed
abstract class ActiveOrderResponseModel with _$ActiveOrderResponseModel {
  const factory ActiveOrderResponseModel({ActiveOrderModel? activeOrder}) =
      _ActiveOrderResponseModel;

  factory ActiveOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveOrderResponseModelFromJson(json);

  const ActiveOrderResponseModel._();

  ActiveOrderResponse toEntity() =>
      ActiveOrderResponse(activeOrder: activeOrder?.toEntity());
}

@freezed
abstract class ActiveOrderAddressModel with _$ActiveOrderAddressModel {
  const factory ActiveOrderAddressModel({
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
  }) = _ActiveOrderAddressModel;

  factory ActiveOrderAddressModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveOrderAddressModelFromJson(json);

  const ActiveOrderAddressModel._();

  ActiveOrderAddress toEntity() => ActiveOrderAddress(
    fullName: fullName,
    company: company,
    streetLine1: streetLine1,
    streetLine2: streetLine2,
    city: city,
    province: province,
    postalCode: postalCode,
    country: country,
    countryCode: countryCode,
    phoneNumber: phoneNumber,
    customFields: customFields,
  );
}

@freezed
abstract class ActiveOrderLineModel with _$ActiveOrderLineModel {
  const factory ActiveOrderLineModel({
    @Default('') String id,
    @Default(0) int unitPrice,
    @Default(0) int unitPriceWithTax,
    @Default(0) int discountedUnitPrice,
    @Default(0) int quantity,
    @Default(0) int linePrice,
    @Default(0) int linePriceWithTax,
    @Default(0) int discountedLinePrice,
    dynamic customFields,
    AssetModel? featuredAsset,
    ProductVariantModel? productVariant,
  }) = _ActiveOrderLineModel;

  factory ActiveOrderLineModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveOrderLineModelFromJson(json);

  const ActiveOrderLineModel._();

  ActiveOrderLine toEntity() => ActiveOrderLine(
    id: id,
    unitPrice: unitPrice,
    unitPriceWithTax: unitPriceWithTax,
    discountedUnitPrice: discountedUnitPrice,
    quantity: quantity,
    linePrice: linePrice,
    linePriceWithTax: linePriceWithTax,
    discountedLinePrice: discountedLinePrice,
    customFields: customFields,
    featuredAsset: featuredAsset?.toEntity(),
    productVariant: productVariant?.toEntity(),
  );
}

@freezed
abstract class ActiveOrderShippingLineModel
    with _$ActiveOrderShippingLineModel {
  const factory ActiveOrderShippingLineModel({
    @Default('') String id,
    @Default(0) int price,
    @Default(0) int priceWithTax,
    @Default(0) int discountedPrice,
    @Default(0) int discountedPriceWithTax,
    dynamic customFields,
  }) = _ActiveOrderShippingLineModel;

  factory ActiveOrderShippingLineModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveOrderShippingLineModelFromJson(json);

  const ActiveOrderShippingLineModel._();

  ActiveOrderShippingLine toEntity() => ActiveOrderShippingLine(
    id: id,
    price: price,
    priceWithTax: priceWithTax,
    discountedPrice: discountedPrice,
    discountedPriceWithTax: discountedPriceWithTax,
    customFields: customFields,
  );
}
