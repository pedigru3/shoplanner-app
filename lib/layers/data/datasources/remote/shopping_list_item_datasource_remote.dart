import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/layers/data/datasources/shopping_list_items_datasource.dart';
import 'package:shoplanner/layers/data/services/http.dart';
import 'package:shoplanner/layers/data/services/http_imp.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_item_exception.dart';
import 'package:shoplanner/layers/domain/errors/shopping_list_items_dataSource_error.dart';
import 'dart:convert';

class ShoppingListItemDataSourceRemote implements ShoppingListItemsDataSource {
  late SharedPreferences prefs;
  final HttpService http = HttpServiceImp();

  @override
  AsyncResult<ShoppingListItemEntity, ShoppingListItemException> create({
    required String name,
    required double quantity,
    required double price,
    required Category category,
    required String shoppingListId,
  }) async {
    final response = await http.post(
      slugUrl: '/shopping-list-item/$shoppingListId',
      body: {
        'name': name,
        'quantity': quantity,
        'price': price,
        'category': category.toStringValue(),
      },
    );
    final shoppingList = ShoppingListItemEntity.fromMap(json.decode(response));
    return Success(shoppingList);
  }

  @override
  AsyncResult<bool, ShoppingListItemException> delete(String id) async {
    try {
      await http.delete('/shopping-list-item/$id');
      return const Success(true);
    } catch (e) {
      return Failure(ShoppingListItemsDataSourceError('error: $e'));
    }
  }

  @override
  AsyncResult<bool, ShoppingListItemException> update(
      {required String id,
      (String name, Category category)? item,
      double? quantity,
      double? price}) async {
    try {
      Map data = {};

      if (item != null) {
        var (name, category) = item;
        data['item'] = {
          'name': name,
          'category': category,
        };
      }

      if (quantity != null) {
        data['quantity'] = quantity;
      }

      if (price != null) {
        data['price'] = price;
      }

      await http.put(
        slugUrl: '/shopping-list-item/$id',
        body: data,
      );

      return const Success(true);
    } catch (e) {
      print(e);
      return Failure(ShoppingListItemsDataSourceError('error: $e'));
    }
  }

  @override
  AsyncResult<Iterable<ItemEntity>, ShoppingListItemException> searchByName(
      String name) async {
    try {
      final response = await http.get('/item/$name');
      final mapjsonList = json.decode(response);
      var result = mapjsonList.map<ItemEntity>((e) => ItemEntity.fromMap(e));
      return Success(result);
    } catch (e) {
      return Failure(ShoppingListItemsDataSourceError('Error Data: $e'));
    }
  }
}
