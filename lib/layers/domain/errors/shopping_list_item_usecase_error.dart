import 'package:shoplanner/layers/domain/errors/shopping_list_item_exception.dart';

class ShoppingListItemUseCaseError extends ShoppingListItemException {
  ShoppingListItemUseCaseError(super.message);

  @override
  String toString() => 'ShoppingListItemUseCaseError: $message';
}
