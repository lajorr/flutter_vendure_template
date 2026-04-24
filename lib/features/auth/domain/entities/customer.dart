import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';

@freezed
abstract class Customer with _$Customer {
  const factory Customer({
    required String id,
    String? createdAt,
    String? updatedAt,
    String? title,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    required String emailAddress,
    dynamic customFields,
  }) = _Customer;
}
