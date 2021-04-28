import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kastutorial/models/user.dart';

class Client {
  static final endpoint = '10.1.1.2:3000';

  static Future<User> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.http(endpoint, '/v1/user'),
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }

    throw Exception('failed to sign in');
  }

  static Future<int> getBalance(String userid) async {
    final response =
        await http.get(Uri.http(endpoint, '/v1/user/$userid/klay'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['balance'];
    }

    throw Exception('failed to get balance');
  }

  static Future<String> sendKlay(
      String userid, String toUserid, int amount) async {
    final response = await http.post(
      Uri.http(endpoint, '/v1/user/$userid/klay'),
      body: {
        "to": toUserid,
        "amount": amount,
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['txHash'];
    }

    throw Exception('failed to send balance');
  }

  static Future<List> getSuggestions(String pattern) async {
    final response = await http
        .get(Uri.http(endpoint, "/v1/search", {"user-pattern": pattern}));

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['users'];
    }

    return [];
  }
}
