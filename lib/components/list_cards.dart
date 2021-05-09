import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kastutorial/components/nft_card.dart';
import 'package:kastutorial/models/nft_token.dart';
import 'package:kastutorial/services/client.dart';

class ListCards extends StatefulWidget {
  final String username;

  const ListCards({
    Key key,
    this.username,
  }) : super(key: key);

  @override
  _ListCardsState createState() => _ListCardsState(this.username);
}

class _ListCardsState extends State<ListCards> {
  static final endpoint = env['CLIENT_URL'];
  String username;
  List<NftToken> tokens = [];

  _ListCardsState(String username) {
    this.username = username;
  }

  @override
  void initState() {
    super.initState();
    Client.listTokens(username).then((value) {
      //print(value);
      setState(() {
        this.tokens = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int rowLimit = 3;
    List<Widget> rows = [];
    for (int i = 0; i < tokens.length; i = i + rowLimit) {
      List<Widget> row = [];
      for (int j = i; j < i + rowLimit && j < tokens.length; j++) {
        row.add(
          NftCard(
            url: 'http://$endpoint' + tokens[j].imageUrl,
            name: tokens[j].name,
            kind: tokens[j].kind,
            tokenId: tokens[j].tokenId,
            username: username,
          ),
          // Spacer(),
        );
      }
      rows.add(
        Row(
          children: row,
        ),
      );
    }
    return Column(
      children: rows,
    );
  }
}