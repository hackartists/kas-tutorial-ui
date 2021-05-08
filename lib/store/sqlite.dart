import 'package:flutter/material.dart';
import 'package:kastutorial/interfaces/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite<T> {
  static Future<Database> database;
  static void initDatabase() {
    database = openDatabase(
      'kas-tutorial-ui.db',
      onCreate: (db, version) {
        return db.execute(
            "create table klay_transfer(id integer primary key autoincrement, eventType text, timestamp integer, target text, value text)");
      },
      version: 1,
    );
  }

  static Future closeDatabase() async {
    Database db = await database;
    return await db.close();
  }

  SqliteModel doc;
  String table;

  Sqlite(String table) {
    this.table = table;
  }

  Future<void> create() async {
    Database db = await database;
    doc.id = await db.insert(table, doc.toMap());
  }

  Future<void> update() async {
    Database db = await database;
    await db.update(table, doc.toMap(), where: 'id = ?', whereArgs: [doc.id]);
  }

  Future<void> delete() async {
    Database db = await database;

    await db.delete(table, where: 'id = ?', whereArgs: [doc.id]);
  }

  Future<List<T>> select() async {
    Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (index) {
      return doc.fromMap(maps[index]);
    });
  }
}
