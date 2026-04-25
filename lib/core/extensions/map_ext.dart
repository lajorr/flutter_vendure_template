extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> get withoutNulls =>
      Map.fromEntries(entries.where((e) => e.value != null));
}
