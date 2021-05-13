class SafeMoney {
  String address;
  String name;
  String creator;
  String image;
  String tokenId;
  dynamic pendings;

  SafeMoney({this.address, this.name, this.creator, this.image, this.tokenId, this.pendings});

  static SafeMoney fromJson(Map<String, dynamic> json) {
    return SafeMoney(
      address: json['address'],
      name: json['name'],
      creator: json['creator'],
      image: json['image'],
      tokenId: json['tokenId'],
      pendings: json['pendings'],
    );
  }
}
