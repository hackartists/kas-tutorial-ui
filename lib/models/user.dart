import 'package:flutter/material.dart';

class User {
  String address;
  int balance;

  User({@required this.address, @required this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      address: json['address'],
      balance: json['balance'],
    );
  }
}
