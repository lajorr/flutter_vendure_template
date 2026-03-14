import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product_variant.dart';
import 'asset_model.dart';
import 'facet_value_model.dart';
import 'product_option_value_model.dart';

part 'product_variant_model.freezed.dart';
part 'product_variant_model.g.dart';

@freezed
abstract class ProductVariantModel with _$ProductVariantModel {
  const factory ProductVariantModel({
    required String id,
    required String name,
    required String sku,
    required int price,
    AssetModel? featuredAsset,
    @Default([]) List<AssetModel> assets,
    String? stockLevel,
    // @Default([]) List<StockLevelModel> stockLevels,
    @JsonKey(name: "options")
    @Default([])
    List<ProductOptionValueModel> optionValues,
    @Default([]) List<FacetValueModel> facetValues,
  }) = _ProductVariantModel;

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantModelFromJson(json);

  const ProductVariantModel._();

  ProductVariant toEntity() => ProductVariant(
    id: id,
    name: name,
    sku: sku,
    price: price,
    featuredAsset: featuredAsset?.toEntity(),
    assets: assets.map((e) => e.toEntity()).toList(),
    stockLevel: stockLevel,
    optionValues: optionValues.map((e) => e.toEntity()).toList(),
    facetValues: facetValues.map((e) => e.toEntity()).toList(),
  );
}
