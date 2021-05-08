import 'package:flutter/material.dart';
import 'package:kastutorial/store/preference.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:kastutorial/store/sqlite.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

Future main() async {
  await DotEnv.load(fileName: '.env');
  await Sqlite.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String address;
  String username;
  String password;

  @override
  void initState() {
    getAccountAddress();
    super.initState();
  }

  getAccountAddress() async {
    Preference.getAddress().then((value) => setState(() {
          address = value;
        }));
    Preference.getUsername().then((value) => setState(() {
          username = value;
        }));
    Preference.getPassword().then((value) => setState(() {
          password = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KAS Tutorial',
      theme: ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.orange,
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.orange),
        // fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          headline3: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            // fontWeight: FontWeight.w400,
            color: Colors.orange,
          ),
          button: TextStyle(
            // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
            fontFamily: 'OpenSans',
          ),
          caption: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.deepPurple[300],
          ),
          headline1: TextStyle(fontFamily: 'Quicksand'),
          headline2: TextStyle(fontFamily: 'Quicksand'),
          headline4: TextStyle(fontFamily: 'Quicksand'),
          headline5: TextStyle(fontFamily: 'NotoSans'),
          headline6: TextStyle(fontFamily: 'NotoSans'),
          subtitle1: TextStyle(fontFamily: 'NotoSans'),
          bodyText1: TextStyle(fontFamily: 'NotoSans'),
          bodyText2: TextStyle(fontFamily: 'NotoSans'),
          subtitle2: TextStyle(fontFamily: 'NotoSans'),
          overline: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      home: username != null &&
              username != "" &&
              password != null &&
              password != ""
          ? HomeScreen(username: username, password: password)
          : LoginScreen(),
      // navigatorObservers: [TransitionRouteObserver()],
      // initialRoute: LoginScreen.routeName,
      // routes: {
      //   LoginScreen.routeName: (context) => LoginScreen(),
      //   DashboardScreen.routeName: (context) => DashboardScreen(),
      // },
    );
  }
}
