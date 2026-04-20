import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_state.freezed.dart';

@freezed
class CartItemState with _$CartItemState {
  const factory CartItemState.initial() = _Initial;
  const factory CartItemState.loading({String? variantId, String? orderLineId}) = _Loading;
  const factory CartItemState.success() = _Success;

  const factory CartItemState.error(String message) = _Error;
}
