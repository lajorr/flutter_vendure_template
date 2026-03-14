import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/facet_value.dart';

part 'facet_value_model.freezed.dart';
part 'facet_value_model.g.dart';

@freezed
abstract class FacetValueModel with _$FacetValueModel {
  const factory FacetValueModel({
    required String id,
    required String name,
    required String code,
  }) = _FacetValueModel;

  factory FacetValueModel.fromJson(Map<String, dynamic> json) =>
      _$FacetValueModelFromJson(json);

  const FacetValueModel._();

  FacetValue toEntity() => FacetValue(id: id, name: name, code: code);
}
