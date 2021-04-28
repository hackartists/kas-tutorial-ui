import 'package:flutter/material.dart';

class User {
  String address;

  User({@required this.address});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      address: json['address'],
    );
  }
}
