import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product.dart';
import 'asset_model.dart';
import 'facet_value_model.dart';
import 'product_option_group_model.dart';
import 'product_variant_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required String slug,
    String? description,
    @Default(true) bool enabled,
    AssetModel? featuredAsset,
    @Default([]) List<AssetModel> assets,
    @Default([]) List<ProductVariantModel> variants,
    @Default([]) List<ProductOptionGroupModel> optionGroups,
    @Default([]) List<FacetValueModel> facetValues,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  const ProductModel._();

  Product toEntity() => Product(
    id: id,
    name: name,
    slug: slug,
    description: description,
    enabled: enabled,
    featuredAsset: featuredAsset?.toEntity(),
    assets: assets.map((e) => e.toEntity()).toList(),
    variants: variants.map((e) => e.toEntity()).toList(),
    optionGroups: optionGroups.map((e) => e.toEntity()).toList(),
    facetValues: facetValues.map((e) => e.toEntity()).toList(),
  );
}
