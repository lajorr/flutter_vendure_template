import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product_option_value.dart';

part 'product_option_value_model.freezed.dart';
part 'product_option_value_model.g.dart';

@freezed
abstract class ProductOptionValueModel with _$ProductOptionValueModel {
  const factory ProductOptionValueModel({
    required String id,
    required String name,
    required String code,
  }) = _ProductOptionValueModel;

  factory ProductOptionValueModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionValueModelFromJson(json);

  const ProductOptionValueModel._();

  ProductOptionValue toEntity() =>
      ProductOptionValue(id: id, name: name, code: code);
}
