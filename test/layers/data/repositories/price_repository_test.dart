import 'dart:math';

import 'package:dson_adapter/dson_adapter.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/consts/enumCategories.dart';
import 'package:shoplanner/consts/tables.dart';
import 'package:shoplanner/database/testDB.dart';
import 'package:shoplanner/layers/domain/entities/item_entity.dart';
import 'package:shoplanner/layers/domain/entities/price_entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_item_entity.dart';
import 'package:test/test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:convert';

void main() {
  // Init ffi loader if needed.
  sqfliteFfiInit();

  const dson = DSON();

  test('simple sqflite example', () async {
    Database db = await DBTest.instance.database;

    //USERS

    await db.insert(Table.users, {
      Column.id: '1',
      Column.name: 'João',
    });

    await db.insert(Table.users, {
      Column.id: '2',
      Column.name: 'Felipe',
    });

    await db.insert(Table.users, {
      Column.id: '3',
      Column.name: 'Niège',
    });

    //ITEMS

    await db.insert(Table.items, {
      Column.id: '1',
      Column.name: 'Macarrão',
      Column.category: 'Alimentos',
    });

    await db.insert(Table.items, {
      Column.id: '2',
      Column.name: 'Feijão',
      Column.category: 'Alimentos',
    });

    await db.insert(Table.items, {
      Column.id: '3',
      Column.name: 'Arroz',
      Column.category: 'Alimentos',
    });

    await db.insert(Table.prices, {
      Column.id: '10',
      Column.price: 5.0,
      Column.itemId: '1',
    });

    await db.insert(Table.prices, {
      Column.id: '20',
      Column.price: 6.0,
      Column.itemId: '1',
    });

    await db.insert(Table.prices, {
      Column.id: '30',
      Column.price: 7.0,
      Column.itemId: '2',
    });

    await db.insert(Table.prices, {
      Column.id: '40',
      Column.price: 8.0,
      Column.itemId: '2',
    });

    await db.insert(Table.prices, {
      Column.id: '50',
      Column.price: 9.0,
      Column.itemId: '2',
    });

    await db.insert(Table.shoppingLists, {
      Column.id: '1',
      Column.name: 'Big',
      Column.userId: '1',
      Column.createdAt: DateTime.now().toIso8601String(),
    });

    await db.insert(Table.shoppingListItems, {
      Column.id: '1',
      Column.quantity: 2,
      Column.currentPrice: 5.0,
      Column.shoppingListId: '1',
      Column.itemId: '1',
    });

    await db.insert(Table.shoppingListItems, {
      Column.id: '2',
      Column.quantity: 2,
      Column.currentPrice: 9.0,
      Column.shoppingListId: '1',
      Column.itemId: '2',
    });

    var shoppingLists = await db.rawQuery('''
     SELECT sl.id as shopping_list_id, sl.name as shopping_list_name, sl.created_at,
     sli.id as shopping_list_item_id, sli.quantity, sli.current_price, sli.created_at as shopping_list_item_created_at,
     i.id as item_id, i.name as item_name, i.category, i.created_at as item_created_at,
     p.id as price_id, p.price, p.created_at as price_created_at
     FROM shopping_lists sl
     LEFT JOIN shopping_list_items sli ON sli.shopping_list_id = sl.id
     LEFT JOIN items i ON i.id = sli.item_id
     LEFT JOIN prices p ON p.item_id = i.id
     WHERE sl.id = ?
    ''', ['1']);

    List<Map<String, dynamic>> transformedData = [];

    for (var item in shoppingLists) {
      // Verifica se já existe um objeto de lista de compras com esse id
      var result = transformedData.where((element) {
        return element['id'] == item['shopping_list_id'];
      }).toList();

      var shoppingList = result.isNotEmpty ? result[0] : null;

      if (shoppingList == null) {
        // Se não existir, cria um novo objeto de lista de compras
        shoppingList = {
          'id': item['shopping_list_id'],
          'marketName': item['shopping_list_name'],
          'created_at': item['created_at'],
          'shoppingListItems': []
        };
        transformedData.add(shoppingList);
      }

      // Verifica se já existe um objeto de item com esse id na lista de itens da lista de compras
      var shoppingListItem = shoppingList['shoppingListItems']
          .firstWhere((t) => t['id'] == item['item_id'], orElse: () => null);

      if (shoppingListItem == null) {
        // Se não existir, cria um novo objeto de item
        shoppingListItem = {
          'id': item['shopping_list_item_id'],
          'item': {
            'id': item['item_id'],
            'name': item['item_name'],
            'category': item['category'],
            'prices': [],
            'created_at': item['item_created_at']
          },
          'currentPrice': item['current_price'],
          'quantity': item['quantity'],
          'created_at': item['shopping_list_item_created_at']
        };
        shoppingList['shoppingListItems'].add(shoppingListItem);
      }

      // Adiciona o novo preço à lista de preços do objeto de item
      var price = {
        'id': item['price_id'],
        'value': item['price'],
        'item_id': item['item_id'],
        'created_at': item['price_created_at']
      };
      shoppingListItem['item']['prices'].add(price);
    }

    var result = ShoppingListEntity.fromMap(transformedData.first);

    print(result.shoppingListItems[0].item.prices[0].value);

    await db.close();
  });
}
