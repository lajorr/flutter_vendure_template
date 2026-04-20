import 'package:freezed_annotation/freezed_annotation.dart';

import 'asset.dart';
import 'facet_value.dart';
import 'product_option_value.dart';

part 'product_variant.freezed.dart';

@freezed
abstract class ProductVariant with _$ProductVariant {
  const ProductVariant._();
  const factory ProductVariant({
    required String id,
    required String name,
    required String sku,
    required int price,
    Asset? featuredAsset,
    required List<Asset> assets,
    String? stockLevel,
    required List<ProductOptionValue> optionValues,
    required List<FacetValue> facetValues,
  }) = _ProductVariant;

  String? get previewImage {
    String? image;
    if (assets.isNotEmpty) {
      image = assets.first.preview;
    } else {
      image = featuredAsset?.preview;
    }
    return image;
  }
}
