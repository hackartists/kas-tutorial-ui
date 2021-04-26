import 'package:flutter/material.dart';

class SendKlayScreen extends StatefulWidget {
  @override
  SendKlayScreenState createState() => SendKlayScreenState();
}

class SendKlayScreenState extends State<SendKlayScreen> {
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
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '전송할 클레이튼 주소',
              ),
            ),
          ),
          Padding(
            padding: new EdgeInsets.only(top: _height / 5),
            child: TextField(
              obscureText: true,
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
