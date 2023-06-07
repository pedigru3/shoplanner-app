import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/data/datasources/shopping_list_datasource.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_exception.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';

class ShoppingListDataSourceMemory implements ShoppingListDataSource {
  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> create(String name) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  AsyncResult<bool, ShoppingListException> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  AsyncResult<List<ShoppingListEntity>, ShoppingListException> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> fetchById(String id) {
    // TODO: implement fetchById
    throw UnimplementedError();
  }

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> update(
      String id, String name) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
