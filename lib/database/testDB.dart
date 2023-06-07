import 'package:path/path.dart';
import '../consts/tables.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBTest {
  DBTest._();

  //create instance of Database
  static final DBTest instance = DBTest._();

  //create instance of SQLiteDatabase
  static Database? _database;

  get database async {
    if (_database != null) return _database!;

    return _initDatabase();
  }

  _initDatabase() async {
    return await databaseFactoryFfi.openDatabase(inMemoryDatabasePath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _onCreate,
        ));
  }

  _onCreate(Database db, int version) async {
    //create a table for itemsentity
    await db.execute(_users);
    await db.execute(_shoppingLists);
    await db.execute(_shoppingListItems);
    await db.execute(_items);
    await db.execute(_prices);
  }

  final String _users = '''
    CREATE TABLE ${Table.users}(
      ${Column.id} TEXT PRIMARY KEY,
      ${Column.name} TEXT NOT NULL,
      ${Column.image} TEXT,
      ${Column.createdAt} TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''';

  final String _shoppingLists = '''
    CREATE TABLE ${Table.shoppingLists}(
      ${Column.id} TEXT PRIMARY KEY,
      ${Column.name} TEXT,
      ${Column.userId} TEXT,
      ${Column.createdAt} TEXT,
      FOREIGN KEY (${Column.userId}) REFERENCES ${Table.users}(${Column.id})
    )
  ''';

  final String _shoppingListItems = '''
    CREATE TABLE ${Table.shoppingListItems}(
      ${Column.id} TEXT PRIMARY KEY,
      ${Column.quantity} REAL,
      ${Column.currentPrice} REAL,
      ${Column.shoppingListId} TEXT,
      ${Column.itemId} TEXT,
      ${Column.createdAt} TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (${Column.shoppingListId}) REFERENCES ${Table.shoppingLists}(${Column.id}),
      FOREIGN KEY (${Column.itemId}) REFERENCES ${Table.items}(${Column.id})
    )
  ''';

  //create a table for itemsentity with unique name
  final String _items = '''
    CREATE TABLE ${Table.items}(
      ${Column.id} TEXT PRIMARY KEY,
      ${Column.name} TEXT UNIQUE,
      ${Column.category} TEXT,
      ${Column.createdAt} TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''';

  final String _prices = '''
    CREATE TABLE ${Table.prices}(
      ${Column.id} TEXT PRIMARY KEY,
      ${Column.price} REAL,
      ${Column.itemId} TEXT,
      ${Column.createdAt} TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (${Column.itemId}) REFERENCES ${Table.items}(${Column.id})
    )
  ''';
}
