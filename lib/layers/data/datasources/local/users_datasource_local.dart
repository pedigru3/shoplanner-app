import 'package:dson_adapter/dson_adapter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shoplanner/consts/tables.dart';
import 'package:shoplanner/database/db.dart';
import 'package:shoplanner/layers/data/datasources/users_datasource.dart';
import 'package:shoplanner/layers/domain/entities/shopping_list_entity.dart';
import 'package:shoplanner/layers/domain/errors/user_datasource_error.dart';
import 'package:shoplanner/layers/domain/errors/user_exception.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';
import 'package:sqflite/sqflite.dart';

class UsersDataSourceLocal implements UsersDataSource {
  late Database db;
  final dson = const DSON();

  @override
  AsyncResult<UserEntity, UserException> create(UserEntity user) async {
    db = await DB.instance.database;
    try {
      var result = await db.insert('users', {
        'name': user.name,
        'image': user.image,
        'created_at': user.createdAt.toIso8601String(),
      });
      if (result > 0) {
        return Success(user);
      } else {
        return Failure(UserDataSourceError('Error creating user in Database'));
      }
    } catch (e) {
      return Failure(UserDataSourceError('Error creating user: $e'));
    }
  }

  @override
  Future<bool> delete(UserEntity user) async {
    db = DB.instance.database as Database;
    var result =
        await db.delete('users', where: 'id = ?', whereArgs: [user.id]);
    if (result > 0) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  AsyncResult<List<UserEntity>, UserException> fetchAll() async {
    db = await DB.instance.database;
    try {
      var users = await db.rawQuery('''SELECT 
        u.${Column.id} AS user_id,
        u.${Column.name} AS user_name,
        sl.${Column.id} AS shoppingList_id,
        sl.${Column.name} AS shoppingList_name,
        sl.${Column.createdAt} AS shoppingList_createdAt
        FROM ${Table.users} AS u
        LEFT JOIN ${Table.shoppingLists} AS sl
        ON u.${Column.id} = sl.${Column.userId}
    ''');

      List<Map<String, dynamic>> usersFormatted = users
          .map((user) => {
                'id': user['user_id'],
                'name': user['user_name'],
                'shoppingLists': users
                    .where((element) =>
                        element['user_id'] == user['user_id'] &&
                        element['shoppingList_id'] != null)
                    .map((e) => {
                          'id': e['shoppingList_id'],
                          'marketName': e['shoppingList_name'],
                          'createdAt': e['shoppingList_createdAt'],
                        })
                    .toList(),
              })
          .toList();

      var userList = usersFormatted
          .map(
            (user) => dson.fromJson(user, UserEntity.new, inner: {
              'shoppingLists':
                  ListParam<ShoppingListEntity>(ShoppingListEntity.new)
            }) as UserEntity,
          )
          .toList();

      return Success(userList);
    } catch (e) {
      return Failure(UserDataSourceError('Error fetching users: $e'));
    }
  }

  @override
  Future<bool> update(UserEntity user) {
    db = DB.instance.database as Database;
    try {
      db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
