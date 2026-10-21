extension StringExtension on String {
  bool get isSingleWord {
    final trimmed = trim().replaceAll(RegExp(r'^[^\w]+|[^\w]+$'), '');
    if (trimmed.isEmpty) return false;
    return trimmed.split(RegExp(r'\s+')).length == 1;
  }
}
