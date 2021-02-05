import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static const _DATA_BASE_NAME = "posts.db";
  static const _DATA_BASE_VERSION = 1;
  static const _TABLE = 'posts';
  static const COLUMN_ID = 'id';
  static const COLUMN_USER_ID = 'userId';
  static const COLUMN_TITLE = 'title';
  static const COLUMN_BODY = 'body';

  // make this a singleton class
  DbHelper._();
  static final DbHelper instance = DbHelper._();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _DATA_BASE_NAME);
    return await openDatabase(path,
        version: _DATA_BASE_VERSION,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_TABLE (
            $COLUMN_ID INTEGER PRIMARY KEY,
            $COLUMN_USER_ID INTEGER,
            $COLUMN_TITLE TEXT,
            $COLUMN_BODY TEXT
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_TABLE, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(_TABLE);
  }
}