// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssetModel _$AssetModelFromJson(Map<String, dynamic> json) => _AssetModel(
  id: json['id'] as String,
  preview: json['preview'] as String,
  source: json['source'] as String,
  name: json['name'] as String?,
);

Map<String, dynamic> _$AssetModelToJson(_AssetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'preview': instance.preview,
      'source': instance.source,
      'name': instance.name,
    };
