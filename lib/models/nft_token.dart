import 'dart:convert';

class NftToken {
  final String tokenId;
  final String name;
  final String kind;
  final String imageUrl;

  NftToken({this.tokenId, this.name, this.kind, this.imageUrl});

  static NftToken fromResponseBody(Map<String, dynamic> body) {
    print(body);
    return NftToken(
      tokenId: body['tokenId'],
      name: body['name'],
      kind: body['kind'],
      imageUrl: body['image'],
    );
  }
}
