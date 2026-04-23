import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/network/session_provider.dart';
import 'package:vendure_flutter_app/features/cart/domain/entities/shipping_method.dart';
import 'package:vendure_flutter_app/features/cart/domain/usecases/set_shipping_method_usecase.dart';

import '../../domain/usecases/fetch_eligible_methods_usecase.dart';
import '../providers/cart_providers.dart';
import 'cart_controller.dart';
import 'cart_state.dart';
import 'shipping_methods_state.dart';

part 'shipping_methods_controller.g.dart';

@riverpod
class ShippingMethodsController extends _$ShippingMethodsController {
  bool _isSettingMethod = false;
  bool get isSettingMethod => _isSettingMethod;

  @override
  ShippingMethodsState build() {
    return const ShippingMethodsState.initial();
  }

  Future<void> fetchEligibleShippingMethods() async {
    state = const ShippingMethodsState.loading();

    final token = await ref.read(sessionTokenProvider.future);

    final result = await ref
        .read(fetchEligibleMethodsUsecaseProvider)
        .execute(FetchEligibleMethodsUsecaseParams(vendureToken: token ?? ''));

    result.fold(
      (failure) {
        state = ShippingMethodsState.error(failure.message);
      },
      (success) {
        ShippingMethod? selectedMethod;
        final cartState = ref.read(cartControllerProvider);
        cartState.maybeWhen(
          success: (activeOrder) {
            if (activeOrder != null && activeOrder.shippingLines.isNotEmpty) {
              final activeMethodId =
                  activeOrder.shippingLines.first.shippingMethodId;
              if (activeMethodId != null) {
                selectedMethod = success
                    .where((m) => m.id == activeMethodId)
                    .firstOrNull;
              }
            }
          },
          orElse: () {},
        );

        state = ShippingMethodsState.success(
          methods: success,
          selectedShippingMethod: selectedMethod,
        );
      },
    );
  }

  Future<void> setShippingMethod(ShippingMethod method) async {
    _isSettingMethod = true;
    ref.notifyListeners();
    // final token = await ref.read(sessionTokenProvider.future);

    // state = ShippingMethodsState.success(
    //   methods: state.shippingMethods,
    //   selectedShippingMethod: method,
    // );
    final result = await ref
        .read(setShippingMethodUsecaseProvider)
        .execute(SetShippingMethodUsecaseParams(methodId: method.id));

    result.fold(
      (failure) {
        _isSettingMethod = false;
      },
      (success) {
        state = ShippingMethodsState.success(
          methods: state.shippingMethods,
          selectedShippingMethod: method,
        );
        _isSettingMethod = false;
        ref.read(cartControllerProvider.notifier).fetchActiveOrder();
      },
    );
    ref.notifyListeners();
  }
}
