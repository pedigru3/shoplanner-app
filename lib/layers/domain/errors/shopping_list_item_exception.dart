abstract class ShoppingListItemException implements Exception {
  final String message;

  ShoppingListItemException(this.message);

  @override
  String toString() => 'ShoppingListItemException: $message';
}
