import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/asset.dart';

part 'asset_model.freezed.dart';
part 'asset_model.g.dart';

@freezed
abstract class AssetModel with _$AssetModel {
  const factory AssetModel({
    required String id,
    required String preview,
    required String source,
    String? name,
  }) = _AssetModel;

  factory AssetModel.fromJson(Map<String, dynamic> json) =>
      _$AssetModelFromJson(json);

  const AssetModel._();

  Asset toEntity() =>
      Asset(id: id, preview: preview, source: source, name: name);
}
