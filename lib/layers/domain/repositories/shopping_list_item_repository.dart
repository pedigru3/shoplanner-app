import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_item_exception.dart';

abstract class ShoppingListItemRepository {
  AsyncResult<ShoppingListItemEntity, ShoppingListItemException> create({
    required String name,
    required double quantity,
    required double price,
    required Category category,
    required String shoppingListId,
  });

  AsyncResult<ShoppingListItemEntity, ShoppingListItemException> update({
    required String id,
    (String name, Category category)? item,
    double? quantity,
    double? price,
  });

  AsyncResult<bool, ShoppingListItemException> delete(String id);

  AsyncResult<Iterable<ItemEntity>, ShoppingListItemException> searchByName(
      String name);
}
