// Database helper untuk simpan kenangan

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/memory.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'buku_kenangan.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE memories (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            imagePath TEXT,
            date TEXT NOT NULL,
            classNumber TEXT DEFAULT '11',
            major TEXT DEFAULT 'TKJ',
            address TEXT,
            phoneNumber TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertMemory(Memory mem) async {
    final dbClient = await db;
    return await dbClient.insert('memories', mem.toMap());
  }

  Future<List<Memory>> getAllMemories({String? filterClass}) async {
    final dbClient = await db;

    final List<Map<String, dynamic>> maps = await dbClient.query(
      'memories',
      where: filterClass != null ? 'classNumber = ?' : null,
      whereArgs: filterClass != null ? [filterClass] : null,
      orderBy: 'date DESC',
    );

    return maps.map((m) => Memory.fromMap(m)).toList();
  }

  Future<int> updateMemory(Memory mem) async {
    final dbClient = await db;
    return await dbClient.update(
      'memories',
      mem.toMap(),
      where: 'id = ?',
      whereArgs: [mem.id],
    );
  }

  Future<int> deleteMemory(int id) async {
    final dbClient = await db;
    return await dbClient.delete('memories', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAll() async {
    final dbClient = await db;
    await dbClient.delete('memories');
  }

  void close() async {
    final dbClient = await db;
    await dbClient.close();
  }
}