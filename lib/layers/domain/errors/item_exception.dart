abstract class ItemException implements Exception {
  final String message;

  ItemException(this.message);

  @override
  String toString() => 'ItemException: $message';
}
