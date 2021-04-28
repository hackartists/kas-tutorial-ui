import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:kastutorial/models/user.dart';
import 'package:kastutorial/services/client.dart';
import 'package:kastutorial/store/preference.dart';
import 'home_screen.dart';

const users = const {
  'luffy': '1234',
};

class LoginScreen extends StatelessWidget {
  String username;
  String password;

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    try {
      User user = await Client.loginUser(data.name, data.password);
      print(user);
      Preference.saveAuthentication(data.name, data.password);
      Preference.saveAccountAddress(user.address);
    } catch (e) {}

    return Future.delayed(loginTime).then((_) {
      username = data.name;
      password = data.password;

      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'KAS Tutorial',
      // theme: LoginTheme(titleStyle: TextStyle(height: 30)),
      logo: 'assets/images/klaytn-logo-green.png',
      onLogin: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return HomeScreen(username: username, password: password);
          },
        ));
      },
      messages: LoginMessages(usernameHint: "Username"),
      emailValidator: (String value) => null,
      hideForgotPasswordButton: true,
      hideSignUpButton: true,
      onRecoverPassword: _recoverPassword,
      onSignup: (LoginData) {},
    );
  }
}
