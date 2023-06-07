import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/consts/tables.dart';
import 'package:shoplanner/database/db.dart';
import 'package:shoplanner/layers/data/datasources/shopping_list_datasource.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_datasource_error.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_exception.dart';
import 'package:sqflite/sqlite_api.dart';

class ShoppingListDataSourceLocal implements ShoppingListDataSource {
  late Database db;

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> create(String name) {
    /* 
    db = await DB.instance.database;
    try {
      await db.insert(Table.shoppingLists, {
        Column.id: shoppingList.id,
        Column.name: shoppingList.name,
        Column.createdAt: shoppingList.createdAt.toIso8601String(),
        Column.userId: userId,
      });
      return Success(shoppingList);
    } catch (e) {
      return Failure(
        ShoppingListDataSourceError('Error in creating shoppingList: $e'),
      );
    }
  } */
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
