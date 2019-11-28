import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'FinalProjectCharacter.db'),
      onCreate: (db, version) {
        db.execute('CREATE TABLE characters(id INTEGER PRIMARY KEY, name TEXT, description TEXT)');
      },
      version: 1,
    );
    return database;
  }
}