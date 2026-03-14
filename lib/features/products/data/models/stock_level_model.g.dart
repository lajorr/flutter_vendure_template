// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockLevelModel _$StockLevelModelFromJson(Map<String, dynamic> json) =>
    _StockLevelModel(
      stockOnHand: (json['stockOnHand'] as num).toInt(),
      stockAllocated: (json['stockAllocated'] as num).toInt(),
    );

Map<String, dynamic> _$StockLevelModelToJson(_StockLevelModel instance) =>
    <String, dynamic>{
      'stockOnHand': instance.stockOnHand,
      'stockAllocated': instance.stockAllocated,
    };
