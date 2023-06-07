abstract class PriceException implements Exception {
  final String message;

  PriceException(this.message);

  @override
  String toString() => 'PriceException: $message';
}
