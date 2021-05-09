import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kastutorial/components/nft_card.dart';
import 'package:kastutorial/components/toast.dart';
import 'package:kastutorial/services/client.dart';

class SendNftCardScreen extends StatefulWidget {
  final String tokenId;
  final String imageUrl;
  final String name;
  final String kind;
  final String username;

  const SendNftCardScreen({
    Key key,
    this.tokenId,
    this.imageUrl,
    this.name,
    this.kind,
    this.username,
  }) : super(key: key);

  @override
  _SendNftCardScreenState createState() => _SendNftCardScreenState();
}

class _SendNftCardScreenState extends State<SendNftCardScreen> {
  final _controller = TextEditingController();
  String toUser;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('카드 전송'),
      ),
      body: Column(
        children: [
          NftCard(
            url: widget.imageUrl,
            name: widget.name,
            kind: widget.kind,
          ),
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  this.toUser = value;
                });
              },
              decoration: InputDecoration(
                labelText: "전송할 사용자 아이디",
                border: OutlineInputBorder(),
              ),
            ),
            suggestionsCallback: (pattern) async {
              print(pattern);
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
              _controller.text = value;
              setState(() {
                toUser = value;
              });
            },
          ),
          Spacer(),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                // Respond to button press
                try {
                  await Client.sendNftToken(
                    widget.username,
                    widget.tokenId,
                    toUser,
                  );
                  Toast.showToast(
                    context,
                    '카드 전송요청이 완료되었습니다.',
                    Colors.greenAccent,
                  );
                } catch (e) {
                  Toast.showToast(
                    context,
                    '카드 전송요청이 실패하였습니다.',
                    Colors.redAccent,
                  );
                } finally {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.send, size: 18),
              label: Text("카드 전송하기"),
            ),
          ),
        ],
      ),
    );
  }
}
