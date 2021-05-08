import 'package:flutter/material.dart';
import 'package:kastutorial/models/klay_transfer.dart';
import 'package:kastutorial/services/client.dart';
import 'package:kastutorial/store/preference.dart';

class KlayHistoryScreen extends StatefulWidget {
  final String userId;

  KlayHistoryScreen({Key key, @required this.userId}) : super(key: key);
  @override
  KlayHistoryScreenState createState() =>
      KlayHistoryScreenState(userId: this.userId);
}

class KlayHistoryScreenState extends State<KlayHistoryScreen> {
  final String userId;
  List<KlayTransfer> history = [];
  int startTimestamp;

  KlayHistoryScreenState({Key key, this.userId});

  @override
  void initState() {
    super.initState();
    Preference.getTimestamp().then((ts) async {
      int end = (DateTime.now().millisecondsSinceEpoch / 1000).round();
      List<KlayTransfer> value = await Client.getKlayHistory(userId, ts, end);
      Preference.saveTimestamp(end);

      setState(() {
        this.history = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KLAY 거래 내역'),
      ),
      body: Container(
        child: ListView(
          children: buildHistory(),
        ),
      ),
    );
  }

  List<ListTile> buildHistory() {
    List<ListTile> ret = [];
    this.history.forEach((element) {
      Color color = element.eventType == 'received'
          ? Colors.blueAccent
          : Colors.redAccent;

      ret.add(
        ListTile(
          title: Text(
            element.value,
            style: TextStyle(color: color),
          ),
          subtitle: Text(element.target),
          leading: Icon(
            Icons.arrow_upward,
            color: color,
          ),
          trailing: Text(
            '받음',
            style: TextStyle(color: color),
          ),
        ),
      );
    });

    return ret;
  }
}
