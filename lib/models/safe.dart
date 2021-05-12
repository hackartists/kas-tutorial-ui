class SafeMoney {
  String address;
  String name;
  String creator;
  String image;

  SafeMoney({this.address, this.name, this.creator, this.image});

  static SafeMoney fromJson(Map<String, dynamic> json) {
    return SafeMoney(
      address: json['address'],
      name: json['name'],
      creator: json['creator'],
      image: json['image'],
    );
  }
}
