class KlayTransfer {
  final int timestamp;
  final String eventType;
  final String target;
  final String value;

  KlayTransfer({this.eventType, this.target, this.value, this.timestamp});

  static KlayTransfer fromJson(Map<String, dynamic> json) {
    return KlayTransfer(
      eventType: json['eventType'],
      target: json['target'],
      value: json['value'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'eventType': eventType,
      'target': target,
      'value': value,
    };
  }
}
