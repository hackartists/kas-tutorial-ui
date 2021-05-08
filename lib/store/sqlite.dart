import 'package:flutter/material.dart';
import 'package:kastutorial/interfaces/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqlite {
  static Database database;
  static Future<void> initDatabase() async {
    database = await openDatabase(
      'kas-tutorial-ui.db',
      onCreate: (db, version) {
        return db.execute(
            "create table klay_transfers(id integer primary key, eventType text, timestamp integer, target text, value text )");
      },
      version: 1,
    );
  }

  final SqliteModel doc;
  final String table;

  Sqlite({@required this.table, @required this.doc});

  Future<void> create() async {}
  Future<void> update() async {}
  Future<void> delete() async {}
  Future<List> select() async {}
}
