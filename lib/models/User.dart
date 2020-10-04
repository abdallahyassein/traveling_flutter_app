import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String phone;
  final String rate;
  final String address;
  final String email;
  final String password;
  final String type;

  User(
    this.id,
    this.name,
    this.phone,
    this.rate,
    this.address,
    this.email,
    this.password,
    this.type,
  );

  String getEmail() {
    return this.email;
  }

  String getName() {
    return this.name;
  }

  String getAddress() {
    return this.address;
  }

  String getPhone() {
    return this.phone;
  }

  String getType() {
    return this.type;
  }

  String getId() {
    return this.id;
  }

  String getPassword() {
    return this.password;
  }

  Map<String, dynamic> toMap(String tokenId) {
    return {
      'id': tokenId,
      'name': name,
      'phone': phone,
      'rate': rate,
      'address': address,
      'email': email,
      'password': password,
      'type': type,
    };
  }

  Map<String, dynamic> toMapDriver(String tokenId) {
    return {
      'id': tokenId,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'password': password,
      'rate': "0",
      'status': "free",
      'type': 'driver'
    };
  }

  static User fromMap(DocumentSnapshot map) {
    if (map == null) return null;

    return User(
      map['id'],
      map['name'],
      map['phone'],
      map['rate'],
      map['address'],
      map['email'],
      map['password'],
      map['type'],
    );
  }

  // String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));
}
