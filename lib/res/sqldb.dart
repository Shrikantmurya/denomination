import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../res/model/history_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('history2.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE counter_list (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      total REAL,
      category TEXT,
      date TEXT,
      time TEXT,
      cashvalue JSON
    );
    ''');
  }

  Future<int> insertData(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('counter_list', row);
  }

  Future<int> updateData(int id, Map<String, dynamic> values) async {
    final db = await instance.database;
    return await db.update(
      'counter_list',
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> retrieveData() async {
    final db = await instance.database;
    return await db.query('counter_list', orderBy: 'id DESC');
  }

  Future<int> deleteData(int id) async {
    final db = await instance.database;
    return await db.delete(
      'counter_list',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
