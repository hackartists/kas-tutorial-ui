import 'package:flutter/material.dart';
import 'package:kastutorial/components/list_cards.dart';
import 'package:kastutorial/screens/issue_nft_screen.dart';

class NftHomeScreen extends StatefulWidget {
  final String username;

  NftHomeScreen({Key key, @required this.username}) : super(key: key);

  @override
  NftHomeScreenState createState() => NftHomeScreenState(this.username);
}

class NftHomeScreenState extends State<NftHomeScreen> {
  String username;

  NftHomeScreenState(String username) {
    this.username = username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 자산 목록'),
      ),
      body: ListCards(username: username),
      floatingActionButton: FloatingActionButton(
        tooltip: '토큰 발행',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return IssueNftScreen(
                  username: username,
                );
              },
            ),
          );
        },
        child: Icon(Icons.create),
      ),
    );
  }
}
