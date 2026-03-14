// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductVariantModel _$ProductVariantModelFromJson(Map<String, dynamic> json) =>
    _ProductVariantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      price: (json['price'] as num).toInt(),
      featuredAsset: json['featuredAsset'] == null
          ? null
          : AssetModel.fromJson(json['featuredAsset'] as Map<String, dynamic>),
      assets:
          (json['assets'] as List<dynamic>?)
              ?.map((e) => AssetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      stockLevel: json['stockLevel'] as String?,
      optionValues:
          (json['options'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ProductOptionValueModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      facetValues:
          (json['facetValues'] as List<dynamic>?)
              ?.map((e) => FacetValueModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductVariantModelToJson(
  _ProductVariantModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sku': instance.sku,
  'price': instance.price,
  'featuredAsset': instance.featuredAsset,
  'assets': instance.assets,
  'stockLevel': instance.stockLevel,
  'options': instance.optionValues,
  'facetValues': instance.facetValues,
};
