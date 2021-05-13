import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kastutorial/components/nft_card.dart';
import 'package:kastutorial/models/nft_token.dart';
import 'package:kastutorial/services/client.dart';

class ListCards extends StatefulWidget {
  final String username;
  final NftCardCallback onTab;
  final dynamic pendings;

  const ListCards({
    Key key,
    this.username,
    this.onTab,
    this.pendings,
  }) : super(key: key);

  @override
  _ListCardsState createState() => _ListCardsState(this.username, this.onTab);
}

class _ListCardsState extends State<ListCards> {
  static final endpoint = env['CLIENT_URL'];
  String username;
  List<NftToken> tokens = [];
  NftCardCallback onTab;

  _ListCardsState(String username, NftCardCallback onTab) {
    this.username = username;
    this.onTab = onTab;
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
    print(widget.pendings);
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
            onTab: onTab,
            color: (widget.pendings == null ||
                    widget.pendings[tokens[j].tokenId] == null)
                ? null
                : Colors.yellowAccent,
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
