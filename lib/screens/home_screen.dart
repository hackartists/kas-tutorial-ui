import 'package:flutter/material.dart';
import 'package:kastutorial/models/user.dart';
import 'package:kastutorial/services/client.dart';
import 'package:kastutorial/store/preference.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String password;

  const HomeScreen({Key key, this.username, this.password}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  User user;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.user = User(address: "", balance: 0);
    });
    getUserInfo();
  }

  getUserInfo() async {
    // TODO: Get user's klaytn address and balance
    final user = await Client.loginUser(widget.username, widget.password);
    setState(() {
      this.user = user;
    });
  }

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
          )
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
                  headerChild('KLAY', this.user.balance),
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
          widget.username,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget headerChild(String header, int value) => new Expanded(
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
