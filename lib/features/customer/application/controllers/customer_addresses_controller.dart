import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/customer/application/controllers/customer_addresses_state.dart';
import 'package:vendure_flutter_app/features/customer/application/providers/customer_providers.dart';
import 'package:vendure_flutter_app/features/customer/domain/entities/customer_address.dart';

part 'customer_addresses_controller.g.dart';

@riverpod
class CustomerAddressesController extends _$CustomerAddressesController {
  @override
  CustomerAddressesState build() {
    return const CustomerAddressesState.initial();
  }

  Future<void> fetchCustomerAddresses() async {
    state = const CustomerAddressesState.loading();

    final result = await ref
        .read(getCustomerAddressesUsecaseProvider)
        .execute(NoParams());

    result.fold(
      (failure) {
        state = CustomerAddressesState.error(failure.message);
      },
      (success) {
        CustomerAddress? defaultAddress;
        if (success.isNotEmpty) {
          defaultAddress = success.firstWhere(
            (address) => address.defaultShippingAddress,
            orElse: () => success.first,
          );
        }

        state = CustomerAddressesState.success(
          addresses: success,
          selectedAddress: defaultAddress,
        );
      },
    );
  }

  void selectAddress(CustomerAddress address) {
    state.maybeWhen(
      success: (addresses, _) {
        state = CustomerAddressesState.success(
          addresses: addresses,
          selectedAddress: address,
        );
      },
      orElse: () {},
    );
  }
}
