import 'package:equatable/equatable.dart';
import 'product_option.dart';

class ProductOptionGroup extends Equatable {
  final String id;
  final String name;
  final String? code;
  final int? productCount;
  final List<ProductOption> options;

  const ProductOptionGroup({
    required this.id,
    required this.name,
    this.code,
    this.productCount,
    required this.options,
  });

  @override
  List<Object?> get props => [id, name, code, productCount, options];
}
