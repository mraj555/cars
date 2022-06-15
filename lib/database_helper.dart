import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper instance = DataBaseHelper._();

  static const databaseName = 'Students.db';
  static const tableName = 'Info';
  static const columnId = 'ID';
  static const columnName = 'Name';
  static const columnMiles = 'Miles';
  static const isFav = 'Like';

  static Database? database;

  Future<Database> get getDatabase async {
    if (database != null) {
      return database!;
    }

    database = await _initdatabase();
    return database!;
  }

  _initdatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databaseName);
    print(path);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,$columnName TEXT NOT NULL,$columnMiles TEXT DEFAULT 123,$isFav BOOL DEFAULT TRUE)''');
    print('Created Table');
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    Database db = await instance.getDatabase;
    return await db.insert(tableName, data);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await instance.getDatabase;
    return await db.query(tableName);
  }

  Future<int> update(Map<String, dynamic> data) async {
    Database db = await instance.getDatabase;
    int id = data[columnId];
    return await db.update(
      tableName,
      data,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.getDatabase;
    return await db
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
