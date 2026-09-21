// Database helper untuk menyimpan kenangan

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/memory.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (database != null) return database!;
    database = await _initDB('memories.db');
    return database!;
  }

  Future<Database> _initDB(String dbName) async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = '${documentsDir.path}/$dbName';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE memories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        imagePath TEXT,
        date TEXT NOT NULL,
        qrData TEXT
      )
    ''');
  }

  Future<List<Memory>> getAllMemories() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('memories', orderBy: 'date DESC');
    return List.generate(maps.length, (i) => Memory.fromMap(maps[i]));
  }

  Future<int> insertMemory(Memory memory) async {
    Database db = await instance.database;
    return await db.insert('memories', memory.toMap());
  }

  Future<int> deleteMemory(int id) async {
    Database db = await instance.database;
    return await db.delete('memories', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteDatabaseFile() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = '${documentsDir.path}/memories.db';
    if (await File(path).exists()) {
      await File(path).delete();
    }
  }
}