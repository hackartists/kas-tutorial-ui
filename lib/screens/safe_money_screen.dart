import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kastutorial/components/list_cards.dart';
import 'package:kastutorial/components/nft_card.dart';
import 'package:kastutorial/components/safe_money_tile.dart';
import 'package:kastutorial/models/klay_transfer.dart';
import 'package:kastutorial/services/client.dart';
import 'package:kastutorial/store/preference.dart';

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
  String tokenId;
  String url;
  String name;
  String kind;
  String safeName;

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
                return Scaffold(
                  appBar: AppBar(
                    title: Text('금고 생성'),
                  ),
                  body: Column(
                    children: [
                      buildSelectedCard(context),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            this.safeName = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '금고 이름',
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      TextField(
                        onChanged: (value) {
                          // TODO: add invited users.
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '초대 사용자',
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {},
                          icon: Icon(Icons.send, size: 18),
                          label: Text("금고 생성"),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            SafeMoneyTile(),
          ],
        ),
      ),
    );
  }

  Center buildSelectedCard(BuildContext context) {
    return Center(
      child: NftCard(
        url: (url == null) ? '' : url,
        name: (name == null) ? '카드 선택' : name,
        kind: (kind == null) ? '' : kind,
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
                    onTab: (tokenId, url, name, kind) {
                      setState(() {
                        this.tokenId = tokenId;
                        this.url = url;
                        this.name = name;
                        this.kind = kind;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: SizedBox(
          width: 200,
          height: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: ColoredBox(
                  color: Colors.lightBlueAccent.withOpacity(0.2),
                  child: null,
                ),
              ),
              ListTile(
                // leading: Icon(Icons.album),
                title: Text(
                  '카드 선택',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                subtitle: Text(
                  '',
                  style: TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
