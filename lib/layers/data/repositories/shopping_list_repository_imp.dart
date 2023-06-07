import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/data/datasources/shopping_list_datasource.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_exception.dart';
import 'package:shoplanner/layers/domain/repositories/shopping_list_repository.dart';

class ShoppingListRepositoryImp implements ShoppingListRepository {
  final ShoppingListDataSource _shoppingListDataSource;

  ShoppingListRepositoryImp(this._shoppingListDataSource);

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> create(String name) {
    return _shoppingListDataSource.create(name);
  }

  @override
  AsyncResult<bool, ShoppingListException> delete(String id) {
    return _shoppingListDataSource.delete(id);
  }

  @override
  AsyncResult<List<ShoppingListEntity>, ShoppingListException> fetchAll() {
    return _shoppingListDataSource.fetchAll();
  }

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> update(
      String id, String name) {
    return _shoppingListDataSource.update(id, name);
  }

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> fetchById(String id) {
    return _shoppingListDataSource.fetchById(id);
  }
}
