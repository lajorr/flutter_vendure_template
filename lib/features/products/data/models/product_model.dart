import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required String id,
    required String slug,
    required String name,
    required String description,
    required String imageUrl,
    required double price,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  // Custom Vendure mapping factory
  factory ProductModel.fromVendureJson(Map<String, dynamic> json) {
    final assets = json['assets'] as List<dynamic>?;
    final String imageUrl = (assets != null && assets.isNotEmpty)
        ? assets.first['preview'] ?? ''
        : '';

    final variants = json['variants'] as List<dynamic>?;
    final int priceWithTax = (variants != null && variants.isNotEmpty)
        ? (variants.first['priceWithTax'] as int? ?? 0)
        : 0;

    return ProductModel(
      id: json['id'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: imageUrl,
      price: priceWithTax / 100.0,
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      slug: slug,
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
    );
  }
}
