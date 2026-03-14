// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      enabled: json['enabled'] as bool? ?? true,
      featuredAsset: json['featuredAsset'] == null
          ? null
          : AssetModel.fromJson(json['featuredAsset'] as Map<String, dynamic>),
      assets:
          (json['assets'] as List<dynamic>?)
              ?.map((e) => AssetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map(
                (e) => ProductVariantModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      optionGroups:
          (json['optionGroups'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ProductOptionGroupModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      facetValues:
          (json['facetValues'] as List<dynamic>?)
              ?.map((e) => FacetValueModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'enabled': instance.enabled,
      'featuredAsset': instance.featuredAsset,
      'assets': instance.assets,
      'variants': instance.variants,
      'optionGroups': instance.optionGroups,
      'facetValues': instance.facetValues,
    };
