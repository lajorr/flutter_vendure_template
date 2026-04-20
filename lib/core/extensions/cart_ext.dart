extension StringExtension on String {
  String get capitalizeFirst =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get capitalizeFirstLetterOfEachWord => isNotEmpty
      ? split(' ').map((word) => word.capitalizeFirst).join(' ')
      : '';
}

extension DoubleExtension on double {
  String get formattedPrice => '\$${toStringAsFixed(2)}';
}
