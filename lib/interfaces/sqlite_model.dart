abstract class SqliteModel {
  int id;

  Map<String, dynamic> toMap();
  dynamic fromMap(Map<String, dynamic> map);
}
