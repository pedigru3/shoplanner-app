import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:result_dart/result_dart.dart';
import '../errors/shopping_list_exception.dart';

abstract class ShoppingListRepository {
  AsyncResult<ShoppingListEntity, ShoppingListException> create(String name);
  AsyncResult<ShoppingListEntity, ShoppingListException> update(
      String id, String name);
  AsyncResult<List<ShoppingListEntity>, ShoppingListException> fetchAll();
  AsyncResult<ShoppingListEntity, ShoppingListException> fetchById(String id);
  AsyncResult<bool, ShoppingListException> delete(String id);
}
