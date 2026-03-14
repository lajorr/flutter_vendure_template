import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product_option.dart';

part 'product_option_model.freezed.dart';
part 'product_option_model.g.dart';

@freezed
abstract class ProductOptionModel with _$ProductOptionModel {
  const factory ProductOptionModel({
    required String id,
    required String name,
    required String code,
  }) = _ProductOptionModel;

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionModelFromJson(json);

  const ProductOptionModel._();

  ProductOption toEntity() => ProductOption(id: id, name: name, code: code);
}
