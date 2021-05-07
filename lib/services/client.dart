import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kastutorial/models/user.dart';

class Client {
  static final endpoint = '172.30.1.17:3000';

  static Future<User> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.http(endpoint, '/v1/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(jsonDecode(response.body));
    }

    throw Exception('failed to sign in');
  }

  static Future<String> getBalance(String userid) async {
    final response =
        await http.get(Uri.http(endpoint, '/v1/user/$userid/klay'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['balance'];
    }

    throw Exception('failed to get balance');
  }

  static Future<String> sendKlay(
      String userid, String toUserid, String amount) async {
    final response = await http.post(
      Uri.http(endpoint, '/v1/user/$userid/klay'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "to": toUserid,
        "amount": amount,
      }),
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
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['users'];
    }

    return [];
  }
}
