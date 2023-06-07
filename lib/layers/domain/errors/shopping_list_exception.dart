abstract class ShoppingListException implements Exception {
  final String message;

  ShoppingListException(this.message);

  @override
  String toString() => 'ShoppingListException: $message';
}
