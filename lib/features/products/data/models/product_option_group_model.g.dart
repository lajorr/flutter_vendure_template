// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductOptionGroupModel _$ProductOptionGroupModelFromJson(
  Map<String, dynamic> json,
) => _ProductOptionGroupModel(
  id: json['id'] as String,
  name: json['name'] as String,
  options: (json['options'] as List<dynamic>)
      .map((e) => ProductOptionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductOptionGroupModelToJson(
  _ProductOptionGroupModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'options': instance.options,
};
