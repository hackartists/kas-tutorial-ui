import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kastutorial/services/client.dart';

class SendKlayScreen extends StatefulWidget {
  final String user;

  const SendKlayScreen({Key key, @required this.user}) : super(key: key);

  @override
  SendKlayScreenState createState() => SendKlayScreenState(user: this.user);
}

class SendKlayScreenState extends State<SendKlayScreen> {
  int amount;
  String toUser;
  String user;
  final _controller = TextEditingController();

  SendKlayScreenState({this.user});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("KLAY 전송 하기"),
      ),
      body: Stack(
        children: [
          Padding(
              padding: new EdgeInsets.only(top: _height / 15),
              child: TypeAheadField(
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
                  _controller.text = value;
                  setState(() {
                    toUser = value;
                  });
                },
              )),
          Padding(
            padding: new EdgeInsets.only(top: _height / 5),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                final n = num.tryParse(value);
                setState(() {
                  this.amount = n;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'KLAY 수량',
              ),
            ),
          ),
          Padding(
            padding: new EdgeInsets.only(top: _height / 1.4),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Respond to button press
                  Client.sendKlay(user, toUser, amount);
                },
                icon: Icon(Icons.send, size: 18),
                label: Text("클레이 전송하기"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
