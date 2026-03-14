import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/stock_level.dart';

part 'stock_level_model.freezed.dart';
part 'stock_level_model.g.dart';

@freezed
abstract class StockLevelModel with _$StockLevelModel {
  const factory StockLevelModel({
    required int stockOnHand,
    required int stockAllocated,
  }) = _StockLevelModel;

  factory StockLevelModel.fromJson(Map<String, dynamic> json) =>
      _$StockLevelModelFromJson(json);

  const StockLevelModel._();

  StockLevel toEntity() =>
      StockLevel(stockOnHand: stockOnHand, stockAllocated: stockAllocated);
}
