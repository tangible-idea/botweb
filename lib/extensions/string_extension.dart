extension StringExtension on String {
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) {
      return this;
    } else {
      return '${substring(0, maxLength)}$suffix';
    }
  }
}