import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kastutorial/models/klay_transfer.dart';
import 'package:kastutorial/models/nft_token.dart';
import 'package:kastutorial/models/safe.dart';
import 'package:kastutorial/models/user.dart';

class Client {
  static final endpoint = env['CLIENT_URL'];

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
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body)['users'];
    }

    return [];
  }

  static Future<List<KlayTransfer>> getKlayHistory(
      String userId, int start, int end) async {
    final response = await http
        .get(Uri.http(endpoint, "/v1/user/$userId/klay/transfer-history", {
      'start-timestamp': start.toString(),
      'end-timestamp': end.toString(),
    }));

    print(response.statusCode);
    List<KlayTransfer> ret = [];
    if (response.statusCode == 200) {
      List<dynamic> history = jsonDecode(response.body);

      history.forEach((element) {
        ret.add(KlayTransfer.fromJson(element));
      });
    }

    return ret;
  }

  static Future<String> issueToken(user, path, name, kind) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.http(endpoint, '/v1/asset/$user/issue'),
    )
      ..fields['name'] = name
      ..fields['kind'] = kind
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        path,
      ));
    var response = await request.send();
    String body = await response.stream.bytesToString();
    print(body);
    String uri = jsonDecode(body)['uri'];

    return 'http://$endpoint$uri';
  }

  static Future<List> listTokens(user) async {
    final response =
        await http.get(Uri.http(endpoint, "/v1/asset/$user/token"));

    List<NftToken> ret = [];
    if (response.statusCode == 200) {
      List<dynamic> history = jsonDecode(response.body);

      history.forEach((element) {
        ret.add(NftToken.fromResponseBody(element));
      });
    }

    return ret;
  }

  static Future<String> sendNftToken(user, tokenId, to) async {
    final response = await http.post(
      Uri.http(endpoint, '/v1/asset/$user/token/$tokenId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "to": to,
      }),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);

      return result['transactionHash'];
    }

    throw Exception('failed to send NFT token');
  }

  static Future<SafeMoney> createSafeMoney(
      userId, safeName, tokenId, invitedUsers, image) async {
    final response = await http.post(
      Uri.http(endpoint, '/v1/safe'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'creator': userId,
        'name': safeName,
        'warrant': tokenId,
        'invitees': invitedUsers,
        'image': image,
      }),
    );

    if (response.statusCode == 200) {
      return SafeMoney.fromJson(jsonDecode(response.body));
    }

    throw Exception('failed to create safe money');
  }

  static Future<List> listSafeMoney(userId) async {
    final response = await http.get(Uri.http(endpoint, '/v1/safe/$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body).map((map) => SafeMoney.fromJson(map));
    }
    return [];
  }
}
