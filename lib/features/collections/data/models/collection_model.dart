import '../../domain/entities/collection.dart';

class CollectionModel {
  final String id;
  final String name;
  final String slug;
  final String imageUrl;

  CollectionModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
  });

  factory CollectionModel.fromVendureJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      imageUrl: json['featuredAsset']?['preview'] as String? ?? '',
    );
  }

  Collection toEntity() {
    return Collection(
      id: id,
      name: name,
      slug: slug,
      imageUrl: imageUrl,
    );
  }
}
