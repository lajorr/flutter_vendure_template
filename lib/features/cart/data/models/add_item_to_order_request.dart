import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_item_to_order_request.freezed.dart';
part 'add_item_to_order_request.g.dart';

@Freezed(toJson: true)
abstract class AddItemToOrderRequest with _$AddItemToOrderRequest {
  const factory AddItemToOrderRequest({
    required String productVariantId,
    @Default(1) int quantity,
  }) = _AddItemToOrderRequest;
}
