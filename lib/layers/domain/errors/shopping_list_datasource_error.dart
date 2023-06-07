import 'package:shoplanner/layers/domain/errors/shopping_list_exception.dart';

class ShoppingListDataSourceError extends ShoppingListException {
  ShoppingListDataSourceError(super.message);

  @override
  String toString() => 'ShoppingListDataSourceError: $message';
}
