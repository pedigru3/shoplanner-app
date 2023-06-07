import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/layers/data/datasources/shopping_list_datasource.dart';
import 'package:shoplanner/layers/data/services/http.dart';
import 'package:shoplanner/layers/data/services/http_imp.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_datasource_error.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_exception.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'dart:convert';

class ShoppingListDataSourceRemote implements ShoppingListDataSource {
  final HttpService http = HttpServiceImp();

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> create(
      String name) async {
    final response =
        await http.post(slugUrl: '/shopping-list', body: {'name': name});
    final shoppingList = ShoppingListEntity.fromMap(json.decode(response));
    return Success(shoppingList);
  }

  @override
  AsyncResult<bool, ShoppingListException> delete(String id) async {
    try {
      await http.delete('/shopping-list/$id');
      return const Success(true);
    } catch (e) {
      return Failure(ShoppingListDataSourceError('error'));
    }
  }

  @override
  AsyncResult<List<ShoppingListEntity>, ShoppingListException>
      fetchAll() async {
    final response = await http.get('/shopping-lists');
    final List<dynamic> jsonList = json.decode(response);
    final shoppingLists =
        jsonList.map((value) => ShoppingListEntity.fromMap(value)).toList();
    return Success(shoppingLists);
  }

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> fetchById(
      String id) async {
    try {
      final response = await http.get('/shopping-list/$id');
      final shoppingList = ShoppingListEntity.fromMap(json.decode(response));
      return Success(shoppingList);
    } catch (error) {
      print(error);
      return Failure(ShoppingListDataSourceError('Error: $error'));
    }
  }

  @override
  AsyncResult<ShoppingListEntity, ShoppingListException> update(
      String id, String name) async {
    final response =
        await http.put(slugUrl: '/shopping-list/$id', body: {'name': name});
    final shoppingList = ShoppingListEntity.fromMap(json.decode(response));
    return Success(shoppingList);
  }
}
