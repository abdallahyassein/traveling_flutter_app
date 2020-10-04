import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class RequestForm {
  final String id;
  final String clientId;
  final String driverId;
  final String address;
  final String details;
  final String phoneNumber;
  final String carType;
  final String status;
  final String rate;
  final String userRate;
  final String price;
  final String createdAt;
  final String finishedAt;
  final String timeDriverAccepted;
  final String paymentMethod;

  RequestForm({
    this.id,
    this.clientId,
    this.driverId,
    this.address,
    this.details,
    this.phoneNumber,
    this.carType,
    this.status,
    this.rate,
    this.userRate,
    this.price,
    this.createdAt,
    this.finishedAt,
    this.timeDriverAccepted,
    this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    var uuid = Uuid();

    return {
      'id': uuid.v4(),
      'clientId': clientId,
      'driverId': driverId,
      'address': address,
      'details': details,
      'phoneNumber': phoneNumber,
      'carType': carType,
      'status': status,
      'rate': rate,
      'userRate': userRate,
      "price": price,
      'createdAt': createdAt,
      'finishedAt': finishedAt,
      'timeDriverAccepted': timeDriverAccepted,
      'paymentMethod': paymentMethod,
    };
  }

  static RequestForm fromMap(DocumentSnapshot map) {
    if (map == null) return null;

    return RequestForm(
      id: map['id'],
      clientId: map['clientId'],
      driverId: map['driverId'],
      address: map['address'],
      details: map['details'],
      phoneNumber: map['phoneNumber'],
      carType: map['carType'],
      status: map['status'],
      rate: map['rate'],
      userRate: map['userRate'],
      price: map['price'],
      createdAt: map['createdAt'],
      finishedAt: map['finishedAt'],
      timeDriverAccepted: map['timeDriverAccepted'],
      paymentMethod: map['paymentMethod'],
    );
  }

  String toJson() => json.encode(toMap());

  static RequestForm fromJson(String source) => fromMap(json.decode(source));
}
