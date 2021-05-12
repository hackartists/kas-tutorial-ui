import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kastutorial/components/create_safe_money.dart';
import 'package:kastutorial/components/list_cards.dart';
import 'package:kastutorial/components/nft_card.dart';
import 'package:kastutorial/components/safe_money_tile.dart';
import 'package:kastutorial/models/klay_transfer.dart';
import 'package:kastutorial/services/client.dart';

class SafeMoneyScreen extends StatefulWidget {
  final String userId;
  final String tokenId;
  final String url;
  final String name;
  final String kind;

  SafeMoneyScreen(
      {Key key,
      @required this.userId,
      this.tokenId,
      this.url,
      this.name,
      this.kind})
      : super(key: key);
  @override
  SafeMoneyScreenState createState() => SafeMoneyScreenState(
        userId: this.userId,
        tokenId: this.tokenId,
        url: this.url,
        name: this.name,
        kind: this.kind,
      );
}

class SafeMoneyScreenState extends State<SafeMoneyScreen> {
  final String userId;
  List<KlayTransfer> history = [];
  int startTimestamp;
  String tokenId;
  String url = '';
  String name = '카드 선택';
  String kind = '';
  String safeName;
  String invitedUser;
  final _controller = TextEditingController();

  SafeMoneyScreenState(
      {Key key, this.userId, this.tokenId, this.url, this.name, this.kind});

  @override
  void initState() {
    super.initState();
    name = (name == null) ? '카드 선택' : name;
    url = (url == null) ? '' : url;
    kind = (kind == null) ? '' : kind;
    this.invitedUser = '';
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
                      SelectWarrantCard(
                        userId: userId,
                        onSelect: (String tokenId) {
                          setState(() {
                            this.tokenId = tokenId;
                          });
                        },
                      ),
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
                      TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _controller,
                          // onChanged: (value) {
                          //   setState(() {
                          //     this.invitedUser = value;
                          //   });
                          // },
                          decoration: InputDecoration(
                            labelText: "전송할 사용자 아이디",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          print(pattern);
                          int ind = pattern.lastIndexOf(' ');
                          pattern = pattern.substring(ind + 1);
                          return await Client.getSuggestions(pattern);
                        },
                        hideOnEmpty: true,
                        suggestionsBoxDecoration:
                            SuggestionsBoxDecoration(elevation: 0.0),
                        itemBuilder: (context, suggestion) {
                          print("sug");
                          print(suggestion);
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (value) {
                          String comb = '$invitedUser $value';
                          if (comb.startsWith(' ')) {
                            comb = comb.substring(1);
                          }
                          _controller.text = comb;
                          setState(() {
                            invitedUser = comb;
                          });
                        },
                      ),
                      Spacer(),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await Client.createSafeMoney(
                                userId, safeName, tokenId, invitedUser);
                          },
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
}
