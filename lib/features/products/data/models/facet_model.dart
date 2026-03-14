import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/facet.dart';

part 'facet_model.freezed.dart';
part 'facet_model.g.dart';

@freezed
abstract class FacetModel with _$FacetModel {
  const factory FacetModel({
    required String id,
    required String name,
    required String code,
  }) = _FacetModel;

  factory FacetModel.fromJson(Map<String, dynamic> json) =>
      _$FacetModelFromJson(json);

  const FacetModel._();

  Facet toEntity() => Facet(id: id, name: name, code: code);
}
