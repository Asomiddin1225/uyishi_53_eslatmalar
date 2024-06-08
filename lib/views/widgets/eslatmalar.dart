/*

Eslatmalar yasaymiz
ochgan paytda 3 tya eslatma bo'lsin

(Eslatm-1,
 Tafsilot: asd asdf aSFV asdfd asdf)

yangi eslatma qo'shish  va o’chirish  ,
o'zgartirish iloji bo'lsin 



SQL bilan ishlaydigan qilib yarating




 */

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uyishi_47_30_05/models/eslatma_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'eslatmalar.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE eslatmalar (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        detail TEXT NOT NULL
      )
    ''');
  }

  Future<List<Eslatma>> getEslatmalar() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('eslatmalar');
    return List.generate(maps.length, (i) {
      return Eslatma.fromMap(maps[i]);
    });
  }

  Future<void> insertEslatma(Eslatma eslatma) async {
    final db = await database;
    await db.insert(
      'eslatmalar',
      eslatma.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEslatma(Eslatma eslatma) async {
    final db = await database;
    await db.update(
      'eslatmalar',
      eslatma.toMap(),
      where: 'id = ?',
      whereArgs: [eslatma.id],
    );
  }

  Future<void> deleteEslatma(int id) async {
    final db = await database;
    await db.delete(
      'eslatmalar',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}


