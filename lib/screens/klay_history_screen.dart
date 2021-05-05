import 'package:flutter/material.dart';

class KlayHistoryScreen extends StatefulWidget {
  @override
  KlayHistoryScreenState createState() => KlayHistoryScreenState();
}

class KlayHistoryScreenState extends State<KlayHistoryScreen> {
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
    return [
      ListTile(
        title: Text(
          "0.1111",
          style: TextStyle(color: Colors.blueAccent),
        ),
        subtitle: Text('0xaaaaaaaaaaaaaaaaaaaa'),
        leading: Icon(
          Icons.arrow_upward,
          color: Colors.blueAccent,
        ),
        trailing: Text(
          '받음',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
      ListTile(
        title: Text(
          "0.1111",
          style: TextStyle(color: Colors.redAccent),
        ),
        subtitle: Text('0xaaaaaaaaaaaaaaaaaaaa'),
        leading: Icon(
          Icons.arrow_downward,
          color: Colors.redAccent,
        ),
        trailing: Text(
          '보냄',
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
    ];
  }
}
