import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kastutorial/components/select_warrant_card.dart';
import 'package:kastutorial/services/client.dart';

class CreateSafeMoneyScreen extends StatefulWidget {
  final String userId;

  CreateSafeMoneyScreen({Key key, @required this.userId}) : super(key: key);

  @override
  CreateSafeMoneyScreenState createState() => CreateSafeMoneyScreenState(this.userId);
}

class CreateSafeMoneyScreenState extends State<CreateSafeMoneyScreen> {
  final String userId;
  String tokenId;
  String url = '';
  String name = '카드 선택';
  String kind = '';
  String safeName;
  String invitedUser;
  final _controller = TextEditingController();

  CreateSafeMoneyScreenState(this.userId);

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
            suggestionsBoxDecoration: SuggestionsBoxDecoration(elevation: 0.0),
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
                    userId, safeName, tokenId, invitedUser,url);
              },
              icon: Icon(Icons.send, size: 18),
              label: Text("금고 생성"),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
        ],
      ),
    );
  }
}
