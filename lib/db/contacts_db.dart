import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Contacts {
  Database? _db;
  Future<Database?> get dB async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "contacts.db");
    Database db = await openDatabase(path, onCreate: _onCreate, version: 1);
    return db;
  }

  FutureOr _onCreate(Database db, int version) {
    db.execute('''
            CREATE TABLE IF NOT EXISTS "contacts" (
            "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , 
            "firstName" TEXT NOT NULL , 
            "lastName" TEXT NOT NULL , 
            "number" TEXT NOT NULL
            )
''');
    print("==============database and table crerated successfully");
  }

  // Add Contact
  addContact(String table, Map<String, dynamic> values) async {
    Database? myDb = await dB;
    int data = await myDb!.insert(table, values);
    return data;
  }

  // read Contact
  readContact(String table) async {
    Database? _myDb = await dB;
    List<Map<String, dynamic>> data = await _myDb!.query(table);
    return data;
  }

  // update Contact
  updateContact(
      String table, Map<String, dynamic> values, String condition) async {
    Database? _myDb = await dB;
    int data = await _myDb!.update(table, values, where: condition);
    return data;
  }

  // delete Contact
  deleteContact(String table, String condition) async {
    Database? _myDb = await dB;
    int data = await _myDb!.delete(table, where: condition);
    return data;
  }
}
