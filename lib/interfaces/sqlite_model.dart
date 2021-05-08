abstract class SqliteModel {
  Map<String, dynamic> toMap();
  void fromMap(Map<String, dynamic> map);
  List fromArray(List list);
}
