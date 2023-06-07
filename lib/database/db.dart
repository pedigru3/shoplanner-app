import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../consts/tables.dart';

class DB {
  DB._();

  //create instance of Database
  static final DB instance = DB._();

  //create instance of SQLiteDatabase
  static Database? _database;

  get database async {
    if (_database != null) return _database!;

    return _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'shoplanner.db'),
      version: 1,
      onCreate: _onCreate,
    );
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
      ${Column.name} TEXT,
      ${Column.image} TEXT DEFAULT 'https://img.freepik.com/free-icon/user_318-804790.jpg',
      ${Column.createdAt} TEXT
    )
  ''';

  final String _shoppingLists = '''
    CREATE TABLE ${Table.shoppingLists}(
      ${Column.id} TEXT PRIMARY KEY,
      ${Column.name} TEXT,
      ${Column.userId} TEXT,
      ${Column.createdAt} TEXT NOT NULL,
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
      ${Column.createdAt} TEXT NOT NULL,
      FOREIGN KEY (${Column.shoppingListId}) REFERENCES ${Table.shoppingLists}(${Column.id}),
      FOREIGN KEY (${Column.itemId}) REFERENCES ${Table.items}(${Column.id})
    )
  ''';

  //create a table for itemsentity with unique name
  final String _items = '''
    CREATE TABLE ${Table.items}(
      ${Column.id} TEXT PRIMARY KEY,
      ${Column.name} TEXT UNIQUE NOT NULL,
      ${Column.category} TEXT NOT NULL,
      ${Column.createdAt} TEXT NOT NULL
    )
  ''';

  final String _prices = '''
    CREATE TABLE ${Table.prices}(
      ${Column.id} TEXT PRIMARY KEY,
      ${Column.price} REAL,
      ${Column.itemId} TEXT,
      ${Column.createdAt} TEXT NOT NULL,
      FOREIGN KEY (${Column.itemId}) REFERENCES ${Table.items}(${Column.id})
    )
  ''';
}
