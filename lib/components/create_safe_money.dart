import 'package:flutter/material.dart';
import 'package:kastutorial/components/nft_card.dart';

import 'list_cards.dart';

typedef void warrantCallback(String tokenId);

class SelectWarrantCard extends StatefulWidget {
  final String userId;
  final warrantCallback onSelect;

  SelectWarrantCard({Key key, this.userId, this.onSelect}) : super(key: key);
  @override
  SelectWarrantCardState createState() => SelectWarrantCardState(this.userId);
}

class SelectWarrantCardState extends State<SelectWarrantCard> {
  String userId;
  String tokenId;
  String url;
  String name;
  String kind;

  SelectWarrantCardState(String userId) {
    this.userId = userId;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      this.tokenId = '';
      this.url = '';
      this.name = '카드 선택';
      this.kind = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: NftCard(
        url: url,
        name: name,
        kind: kind,
        tokenId: tokenId,
        width: 150,
        onTab: (t, u, n, k) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('카드 선택'),
                  ),
                  floatingActionButton: FloatingActionButton(
                    tooltip: 'label',
                    onPressed: () {},
                    child: Icon(Icons.search),
                  ),
                  body: ListCards(
                    username: this.userId,
                    onTab: this.cardSelectionCallback,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void cardSelectionCallback(tokenId, url, name, kind) {
    print(url);
    Navigator.of(context).pop();
    widget.onSelect(tokenId);
    setState(() {
      this.tokenId = tokenId;
      this.url = url;
      this.name = name;
      this.kind = kind;
    });
  }
}
