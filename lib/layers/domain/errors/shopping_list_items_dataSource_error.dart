import 'package:shoplanner/layers/domain/errors/shopping_list_item_exception.dart';

class ShoppingListItemsDataSourceError extends ShoppingListItemException {
  ShoppingListItemsDataSourceError(super.message);

  @override
  String toString() => 'ShoppingListItemsDataSourceError: $message';
}
