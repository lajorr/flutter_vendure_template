import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vendure_flutter_app/features/customer/domain/entities/customer_address.dart';

part 'customer_addresses_state.freezed.dart';

@freezed
class CustomerAddressesState with _$CustomerAddressesState {
  const factory CustomerAddressesState.initial() = _Initial;
  const factory CustomerAddressesState.loading() = _Loading;
  const factory CustomerAddressesState.success({
    required List<CustomerAddress> addresses,
    CustomerAddress? selectedAddress,
  }) = _Success;
  const factory CustomerAddressesState.error(String message) = _Error;
}
