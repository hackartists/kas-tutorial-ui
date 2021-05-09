import 'dart:convert';

class NftToken {
  final String tokenId;
  final String name;
  final String kind;
  final String imageUrl;

  NftToken({this.tokenId, this.name, this.kind, this.imageUrl});

  static NftToken fromResponseBody(Map<String, dynamic> body) {
    Map<String, dynamic> meta = jsonDecode(body['tokenUri']);
    return NftToken(
      tokenId: body['tokenId'],
      name: meta['name'],
      kind: meta['kind'],
      imageUrl: meta['image'],
    );
  }
}
