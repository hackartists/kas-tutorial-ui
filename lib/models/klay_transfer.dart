import 'package:kastutorial/interfaces/sqlite_model.dart';
import 'package:kastutorial/store/sqlite.dart';

class KlayTransfer extends Sqlite<KlayTransfer> implements SqliteModel {
  @override
  int id;

  final int timestamp;
  final String eventType;
  final String target;
  final String value;

  KlayTransfer({this.eventType, this.target, this.value, this.timestamp})
      : super('klay_transfer') {
    super.doc = this;
  }

  static KlayTransfer fromJson(Map<String, dynamic> json) {
    return KlayTransfer(
      eventType: json['eventType'],
      target: json['target'],
      value: json['value'],
      timestamp: json['timestamp'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> ret = {
      'timestamp': timestamp,
      'eventType': eventType,
      'target': target,
      'value': value,
    };
    if (id != null) {
      ret['id'] = id;
    }

    return ret;
  }

  @override
  dynamic fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    KlayTransfer ret = fromJson(map);
    ret.id = map['id'];

    return ret;
  }
}
