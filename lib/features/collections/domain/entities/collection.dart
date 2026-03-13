import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String? imageUrl;

  const Collection({
    required this.id,
    required this.name,
    required this.slug,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, slug, imageUrl];
}
