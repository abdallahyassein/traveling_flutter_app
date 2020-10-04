import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String email;
  final String password;
  final String type;
  final String rate;
  final String status;

  Driver(
    this.id,
    this.name,
    this.phone,
    this.address,
    this.email,
    this.password,
    this.type,
    this.rate,
    this.status,
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

  static Driver fromMap(DocumentSnapshot map) {
    if (map == null) return null;

    return Driver(
      map['id'],
      map['name'],
      map['phone'],
      map['address'],
      map['email'],
      map['password'],
      map['type'],
      map['rate'],
      map['status'],
    );
  }
}
