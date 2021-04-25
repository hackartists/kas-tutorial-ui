import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kastutorial/models/user.dart';

class Client {
  static Future<User> loginUser(String username, String password) async {
    final response =
        await http.post(Uri.http('10.1.1.2:3000', '/v1/user'), body: {
      "username": username,
      "password": password,
    });

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }

    throw Exception('failed to sign in');
  }
}
