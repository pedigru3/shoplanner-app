import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/data/datasources/shopping_list_items_datasource.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_item_exception.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';
import '../../domain/repositories/shopping_list_item_repository.dart';

class ShoppingListItemRepositoryImp implements ShoppingListItemRepository {
  final ShoppingListItemsDataSource _shoppingListItemDataSource;

  ShoppingListItemRepositoryImp(this._shoppingListItemDataSource);

  @override
  AsyncResult<ShoppingListItemEntity, ShoppingListItemException> create(
      {required String name,
      required double quantity,
      required double price,
      required Category category,
      required String shoppingListId}) {
    return _shoppingListItemDataSource.create(
      name: name,
      quantity: quantity,
      price: price,
      category: category,
      shoppingListId: shoppingListId,
    );
  }

  @override
  AsyncResult<bool, ShoppingListItemException> delete(String id) {
    return _shoppingListItemDataSource.delete(id);
  }

  @override
  AsyncResult<ShoppingListItemEntity, ShoppingListItemException> update(
      {required String id,
      (String, Category)? item,
      double? quantity,
      double? price}) {
    return _shoppingListItemDataSource.update(
      id: id,
      item: item,
      price: price,
      quantity: quantity,
    );
  }

  @override
  AsyncResult<Iterable<ItemEntity>, ShoppingListItemException> searchByName(
      String name) {
    return _shoppingListItemDataSource.searchByName(name);
  }
}
