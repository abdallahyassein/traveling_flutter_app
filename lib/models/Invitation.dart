import 'package:cloud_firestore/cloud_firestore.dart';

class Invitation {
  String id;
  String driverId;

  String clientId;
  String issueId;

  Invitation({
    this.id,
    this.driverId,
    this.clientId,
    this.issueId,
  });

  static Invitation fromMap(DocumentSnapshot map) {
    if (map == null) return null;

    return Invitation(
      id: map['id'],
      driverId: map['driverId'],
      clientId: map['clientId'],
      issueId: map['issueId'],
    );
  }
}
