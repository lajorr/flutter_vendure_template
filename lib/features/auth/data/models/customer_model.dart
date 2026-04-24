import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/customer.dart';

part 'customer_model.freezed.dart';
part 'customer_model.g.dart';

@freezed
abstract class CustomerModel with _$CustomerModel {
  const CustomerModel._();
  const factory CustomerModel({
    required String id,
    String? createdAt,
    String? updatedAt,
    String? title,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    required String emailAddress,
    dynamic customFields,
  }) = _CustomerModel;

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Customer toEntity() {
    return Customer(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      title: title,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      emailAddress: emailAddress,
      customFields: customFields,
    );
  }
}
