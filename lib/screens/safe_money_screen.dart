import 'package:flutter/material.dart';
import 'package:kastutorial/components/safe_money_tile.dart';
import 'package:kastutorial/models/safe.dart';
import 'package:kastutorial/screens/create_safe_money_screen.dart';
import 'package:kastutorial/services/client.dart';

class SafeMoneyScreen extends StatefulWidget {
  final String userId;

  SafeMoneyScreen({Key key, @required this.userId}) : super(key: key);
  @override
  SafeMoneyScreenState createState() =>
      SafeMoneyScreenState(userId: this.userId);
}

class SafeMoneyScreenState extends State<SafeMoneyScreen> {
  final String userId;
  List<SafeMoney> safes = [];
  int startTimestamp;

  SafeMoneyScreenState({Key key, this.userId});

  @override
  void initState() {
    super.initState();

    Client.listSafeMoney(userId).then((value) {
      setState(() {
        this.safes = value;
      });

      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공동 금고'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '금고 만들기',
        child: Icon(Icons.security),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return CreateSafeMoneyScreen(userId: userId);
              },
            ),
          );
        },
      ),
      body: Container(
        child: buildListView(),
      ),
    );
  }

  ListView buildListView() {
    List<Widget> widgets = [];

    for (final el in this.safes) {
      widgets.add(
        SafeMoneyTile(
          name: el.name,
          creator: el.creator,
          image: el.image,
        ),
      );
    }
    return ListView(
      children: [
        Padding(padding: EdgeInsets.only(top: 1)),
       ...widgets,
      ],
    );
  }
}
