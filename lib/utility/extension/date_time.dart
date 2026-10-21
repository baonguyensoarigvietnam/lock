extension DateParsingExtension on String? {
  /// Parses the string into a [DateTime].
  ///
  /// Supports:
  /// - Unix timestamp in milliseconds.
  /// - ISO 8601 date string.
  ///
  /// Returns [fallback] if parsing fails.
  DateTime toDateTime({DateTime? fallback}) {
    final value = this;

    if (value == null || value.isEmpty) {
      return fallback ?? DateTime.now();
    }

    final milliseconds = int.tryParse(value);
    if (milliseconds != null) {
      return DateTime.fromMillisecondsSinceEpoch(milliseconds);
    }

    return DateTime.tryParse(value) ?? (fallback ?? DateTime.now());
  }
}
