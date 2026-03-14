import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product_option_group.dart';
import 'product_option_model.dart';

part 'product_option_group_model.freezed.dart';
part 'product_option_group_model.g.dart';

@freezed
abstract class ProductOptionGroupModel with _$ProductOptionGroupModel {
  const factory ProductOptionGroupModel({
    required String id,
    required String name,
    required List<ProductOptionModel> options,
  }) = _ProductOptionGroupModel;

  factory ProductOptionGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionGroupModelFromJson(json);

  const ProductOptionGroupModel._();

  ProductOptionGroup toEntity() => ProductOptionGroup(
    id: id,
    name: name,
    options: options.map((e) => e.toEntity()).toList(),
  );
}
