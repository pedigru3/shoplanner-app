import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';

abstract class SaveShoppingListUseCase {
  Future<void> call(ShoppingListEntity shoppingListEntity);
}
