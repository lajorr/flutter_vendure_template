import 'package:freezed_annotation/freezed_annotation.dart';

part 'adjust_order_line_request.freezed.dart';
part 'adjust_order_line_request.g.dart';

@Freezed(toJson: true)
abstract class AdjustOrderLineRequest with _$AdjustOrderLineRequest {
  const factory AdjustOrderLineRequest({
    required String orderLineId,
    required int quantity,
  }) = _AdjustOrderLineRequest;
}
