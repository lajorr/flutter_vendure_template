import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vendure_flutter_app/core/usecases/usecase.dart';
import 'package:vendure_flutter_app/features/cart/application/controllers/cart_controller.dart';
import 'package:vendure_flutter_app/features/cart/application/providers/cart_providers.dart';
import 'package:vendure_flutter_app/features/customer/application/controllers/customer_addresses_state.dart';
import 'package:vendure_flutter_app/features/customer/application/providers/customer_providers.dart';
import 'package:vendure_flutter_app/features/customer/domain/entities/customer_address.dart';
import 'package:vendure_flutter_app/shared/models/create_address_input.dart';

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

  Future<void> selectAddress(CustomerAddress address) async {
    state.maybeWhen(
      success: (addresses, _) async {
        state = CustomerAddressesState.success(
          addresses: addresses,
          selectedAddress: address,
        );

        final input = CreateAddressInput(
          fullName: address.fullName,
          streetLine1: address.streetLine1 ?? '',
          streetLine2: address.streetLine2,
          city: address.city,
          province: address.province,
          postalCode: address.postalCode,
          countryCode: address.country.code,
          phoneNumber: address.phoneNumber,
          defaultShippingAddress: address.defaultShippingAddress,
          defaultBillingAddress: address.defaultBillingAddress,
        );

        await ref.read(setShippingAddressUsecaseProvider).execute(input);
        await ref.read(setBillingAddressUsecaseProvider).execute(input);

        // Refresh active order to update shippingAddressProvider
        await ref.read(cartControllerProvider.notifier).fetchActiveOrder();
      },
      orElse: () {},
    );
  }
}
