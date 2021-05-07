import 'package:flutter/material.dart';
import 'package:kastutorial/models/klay_transfer.dart';
import 'package:kastutorial/services/client.dart';

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

  KlayHistoryScreenState({Key key, this.userId});

  @override
  void initState() {
    super.initState();
    Client.getKlayHistory(
      userId,
      (DateTime.now().subtract(Duration(days: 30)).millisecondsSinceEpoch /
              1000)
          .round(),
    )
        .then((value) => setState(() {
              this.history = value;
            }))
        .catchError((err) => print(err));
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
