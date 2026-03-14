import 'package:equatable/equatable.dart';

import 'asset.dart';
import 'facet_value.dart';
import 'product_option_value.dart';

class ProductVariant extends Equatable {
  final String id;
  final String name;
  final String sku;
  final int price;
  final Asset? featuredAsset;
  final List<Asset> assets;
  // final List<StockLevel> stockLevels;
  final String? stockLevel;
  final List<ProductOptionValue> optionValues;
  final List<FacetValue> facetValues;

  const ProductVariant({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    this.featuredAsset,
    required this.assets,
    this.stockLevel,
    required this.optionValues,
    required this.facetValues,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    sku,
    price,
    featuredAsset,
    assets,
    stockLevel,
    optionValues,
    facetValues,
  ];
}
