import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kastutorial/components/app_button.dart';
import 'package:kastutorial/screens/klay_history_screen.dart';
import 'package:kastutorial/screens/nft_home_screen.dart';
import 'package:kastutorial/screens/safe_money_screen.dart';
import 'package:kastutorial/screens/send_klay_screen.dart';
import 'package:kastutorial/services/client.dart';
import 'package:kastutorial/store/preference.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String password;

  HomeScreen({Key key, this.username, this.password}) : super(key: key);

  @override
  HomeScreenState createState() =>
      HomeScreenState(username: this.username, password: this.password);
}

class HomeScreenState extends State<HomeScreen> {
  String username;
  String password;
  String address;
  String balance;

  HomeScreenState({this.username, this.password});

  @override
  void initState() {
    setState(() {
      this.balance = '-';
    });
    super.initState();
    if (username != null) {
      Client.getBalance(username).then((value) => setState(() {
            this.balance = value;
          }));
    }
    Timer.periodic(new Duration(seconds: 60), (timer) async {
      print(username);
      String balance = await Client.getBalance(username);
      setState(() {
        this.balance = balance;
      });
    });

    Preference.getUsername().then((value) => setState(() {
          this.username = value;
        }));

    Preference.getPassword().then((value) => setState(() {
          this.password = value;
        }));

    Preference.getAddress().then((value) => setState(() {
          this.address = value;
        }));
  }

  sendKlay() async {}

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return new Container(
      child: new Stack(
        children: <Widget>[
          // new Container(
          //   decoration: new BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: const Radius.circular(20.0),
          //       bottomRight: const Radius.circular(20.0),
          //     ),
          //     gradient: new LinearGradient(colors: [
          //       const Color(0xFFFFCBE6),
          //       const Color(0xFF26CBFF),
          //     ], begin: Alignment.topCenter, end: Alignment.center),
          //   ),
          // ),
          new Scaffold(
            backgroundColor: Colors.transparent,
            body: buildContainer(_height, _width),
            floatingActionButton: FloatingActionButton(
              tooltip: 'KLAY 전송',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SendKlayScreen(user: this.username);
                  },
                ));
              },
              child: Icon(Icons.send),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ],
      ),
    );
  }

  Container buildContainer(double _height, double _width) {
    return new Container(
      decoration: new BoxDecoration(
          // gradient: new LinearGradient(
          //   colors: [
          //     const Color(0xFFFFCBE6),
          //     const Color(0xFF26CBFF),
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.center,
          // ),
          ),
      child: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              gradient: new LinearGradient(
                colors: [
                  const Color(0xFFFFCBE6),
                  const Color(0xFF26CBFF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: new Align(
              alignment: Alignment.center,
              child: new Padding(
                padding: new EdgeInsets.only(top: _height / 15),
                child: buildProfile(_height),
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(top: _height / 2.2),
            child: new Container(
              color: Colors.white,
            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(
              top: _height / 2.6,
              left: _width / 20,
              right: _width / 20,
            ),
            child: buildProfileInfo(_width),
          ),
          new Padding(
            padding: new EdgeInsets.only(top: _height / 1.9),
            child: Center(
              widthFactor: _width,
              child: Column(
                children: [
                  new Row(
                    children: [
                      Spacer(),
                      AppButton(
                        label: "거래내역",
                        icon: Icons.history,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return KlayHistoryScreen(userId: this.username);
                              },
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      AppButton(
                        label: "자산",
                        icon: Icons.card_giftcard,
                        color: Colors.blueAccent,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return NftHomeScreen(
                                  username: username,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      AppButton(
                        label: "공동금고",
                        icon: Icons.monetization_on,
                        color: Colors.amberAccent,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SafeMoneyScreen(
                                  userId: username,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      // AppButton(
                      //   label: "포인트",
                      //   icon: Icons.credit_card,
                      //   color: Colors.blueAccent,
                      //   onPressed: () {},
                      // ),
                    ],
                  ),
                  new Row(
                    children: [],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildProfileInfo(double _width) {
    return new Column(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            boxShadow: [
              new BoxShadow(
                color: Colors.black45,
                blurRadius: 2.0,
                offset: new Offset(0.0, 2.0),
              )
            ],
          ),
          child: new Padding(
            padding: new EdgeInsets.all(_width / 20),
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  headerChild('KLAY', this.balance),
                  // headerChild('Followers', 1205),
                  // headerChild('Following', 360),
                ]),
          ),
        ),
        // buildPadding(_height, _width)
      ],
    );
  }

  Column buildProfile(double _height) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage:
              new AssetImage('assets/images/klaytn-logo-green.png'),
          radius: _height / 10,
        ),
        new SizedBox(
          height: _height / 30,
        ),
        new Text(
          this.username,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget headerChild(String header, String value) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(header),
          new SizedBox(
            height: 8.0,
          ),
          new Text(
            '$value',
            style: new TextStyle(
                fontSize: 14.0,
                color: const Color(0xFF26CBE6),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new SizedBox(
                width: width / 10,
              ),
              new Icon(
                icon,
                color: const Color(0xFF26CBE6),
                size: 36.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
}
