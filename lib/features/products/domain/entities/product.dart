import 'package:equatable/equatable.dart';

import 'asset.dart';
import 'facet_value.dart';
import 'product_option_group.dart';
import 'product_variant.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String? description;
  final bool enabled;
  final Asset? featuredAsset;
  final List<Asset> assets;
  final List<ProductVariant> variants;
  final List<ProductOptionGroup> optionGroups;
  final List<FacetValue> facetValues;

  const Product({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.enabled,
    this.featuredAsset,
    required this.assets,
    required this.variants,
    required this.optionGroups,
    required this.facetValues,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    description,
    enabled,
    featuredAsset,
    assets,
    variants,
    optionGroups,
    facetValues,
  ];
}

extension ProductX on Product {
  ProductVariant? get getFirstVariant {
    if (variants.isEmpty) return null;
    return variants.first;
  }
}

extension ProductVariantX on ProductVariant? {
  String get formattedPrice {
    final currency = "Rs.";
    if (this == null) {
      return "";
    }
    final price = (this!.price / 100).toStringAsFixed(2);
    return "$currency $price";
  }
}
