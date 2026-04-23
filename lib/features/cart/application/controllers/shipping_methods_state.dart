import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/shipping_method.dart';

part 'shipping_methods_state.freezed.dart';

@freezed
class ShippingMethodsState with _$ShippingMethodsState {
  const factory ShippingMethodsState.initial() = _Initial;
  const factory ShippingMethodsState.loading() = _Loading;
  const factory ShippingMethodsState.success({
    required List<ShippingMethod> methods,
    ShippingMethod? selectedShippingMethod,
  }) = _Success;
  const factory ShippingMethodsState.error(String message) = _Error;
}

extension ShippingMethodsStateExt on ShippingMethodsState {
  List<ShippingMethod> get shippingMethods =>
      maybeWhen(success: (methods, _) => methods, orElse: () => []);

  List<ShippingMethod> get deliveryMethods =>
      shippingMethods.where((m) => !_isPickUp(m)).toList();

  List<ShippingMethod> get pickUpMethods =>
      shippingMethods.where((m) => _isPickUp(m)).toList();

  bool _isPickUp(ShippingMethod method) {
    final lowerName = method.name.toLowerCase();
    final lowerCode = method.code.toLowerCase();
    return lowerName.contains('pickup') ||
        lowerName.contains('pick up') ||
        lowerCode.contains('pickup') ||
        lowerCode.contains('pick-up');
  }
}
