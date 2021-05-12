import 'package:flutter/material.dart';
import 'package:kastutorial/components/safe_money_tile.dart';
import 'package:kastutorial/models/klay_transfer.dart';
import 'package:kastutorial/screens/create_safe_money_screen.dart';

class SafeMoneyScreen extends StatefulWidget {
  final String userId;

  SafeMoneyScreen({Key key, @required this.userId}) : super(key: key);
  @override
  SafeMoneyScreenState createState() =>
      SafeMoneyScreenState(userId: this.userId);
}

class SafeMoneyScreenState extends State<SafeMoneyScreen> {
  final String userId;
  List<KlayTransfer> history = [];
  int startTimestamp;

  SafeMoneyScreenState({Key key, this.userId});

  @override
  void initState() {
    super.initState();
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
    return ListView(
      children: [
        Padding(padding: EdgeInsets.only(top: 10)),
        SafeMoneyTile(
          name: "테스트 금고",
          creator: "Luffy",
          image: "http://morimuri.co.kr/web/product/big/morimurij_672.jpg",
        ),
      ],
    );
  }
}
