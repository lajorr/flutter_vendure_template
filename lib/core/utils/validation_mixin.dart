import 'package:phone_numbers_parser/phone_numbers_parser.dart';

mixin ValidationMixin {
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhoneNumber(String? value, String countryCode) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    try {
      final isoCode = IsoCode.values.byName(countryCode.toUpperCase());
      final phoneNumber = PhoneNumber.parse(value.trim(), destinationCountry: isoCode);
      if (!phoneNumber.isValid()) {
        return 'Invalid phone number';
      }
    } catch (e) {
      return 'Invalid phone number';
    }
    return null;
  }

  String? getInternationalPhoneNumber(String? value, String countryCode) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    try {
      final isoCode = IsoCode.values.byName(countryCode.toUpperCase());
      final phoneNumber = PhoneNumber.parse(
        value.trim(),
        destinationCountry: isoCode,
      );
      return phoneNumber.international;
    } catch (e) {
      return value.trim();
    }
  }
}
