import 'package:sqflite/sqflite.dart';

import '../Model/user_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const int version = 1;
  static const String tableName = "userTable";

  static Future<void> initDatabase() async {
    if (_database != null) {
      return;
    }

    try {
      String path = '${await getDatabasesPath()}userData.db';

      _database = await openDatabase(
        path,
        version: version,
        onCreate: (db, version) async {
          // USER TABLE
          await db.execute(
            '''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            mobileNo TEXT NOT NULL,
            dob TEXT NOT NULL,
            profileImg TEXT,
            age TEXT NOT NULL
          )
          ''',
          );

          // QUALIFICATION TABLE
          await db.execute(
            '''
          CREATE TABLE qualifications(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            qualification TEXT,
            passing_year TEXT,
            marks TEXT
          )
          ''',
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(UserModel userModel) async {
    return await _database!.insert(tableName, userModel.toJson());
  }

  static Future<int> delete(UserModel userModel) async {
    return await _database!.delete(tableName, where: "id = ?", whereArgs: [userModel.id]);
  }

  static Future<int> deleteAll() async {
    return await _database!.delete(tableName);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return _database!.query(tableName);
  }

  static Future<int> update(UserModel userModel) async {
    return _database!.update(tableName, userModel.toJson(), where: "id = ?", whereArgs: [userModel.id]);
  }
}
