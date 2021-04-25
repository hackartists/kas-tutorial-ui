import 'package:flutter/material.dart';

class User {
  final String address;
  final int balance;

  User({@required this.address, @required this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      address: json['address'],
      balance: json['balance'],
    );
  }
}
