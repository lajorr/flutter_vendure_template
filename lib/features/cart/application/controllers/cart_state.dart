import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/active_order.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.loading() = _Loading;
  const factory CartState.success({ActiveOrder? activeOrder}) = _Success;

  const factory CartState.error(String message) = _Error;
}

extension CartStateExt on CartState {
  ActiveOrderStateEnum get activeOrderState => maybeWhen(
    success: (activeOrder) {
      final state = activeOrder?.state ?? "";
      return ActiveOrderStateEnum.fromString(state);
    },
    orElse: () => ActiveOrderStateEnum.addingItems,
  );
}

enum ActiveOrderStateEnum {
  addingItems,
  arrangingPayment;

  static ActiveOrderStateEnum fromString(String state) {
    switch (state.toLowerCase()) {
      case "addingitems":
        return ActiveOrderStateEnum.addingItems;
      case "arrangingpayment":
        return ActiveOrderStateEnum.arrangingPayment;
      default:
        return ActiveOrderStateEnum.addingItems;
    }
  }
}
