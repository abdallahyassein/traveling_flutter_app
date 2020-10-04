import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanicscarfix/models/User.dart';

Firestore firestore = Firestore.instance;

class MixHelper {
  static Future updateStatus(String driverId, String status) async {
    await firestore
        .collection('users')
        .where("id", isEqualTo: driverId)
        .getDocuments()
        .then((snapshot) {
      //print("Found it");
      snapshot.documents.first.reference.updateData({
        "status": status,
      });
    });
  }

  static Future deleteForm(
    String issueId,
    String driverId,
  ) async {
    await firestore
        .collection('issues')
        .where("id", isEqualTo: issueId)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.first.reference.delete();

      if (driverId != "") {
        updateStatus(driverId, "free");
      }
    });
  }

  static Future<List<User>> getAllUsers(String type) async {
    List<User> users = [];

    await firestore
        .collection('users')
        .where("type", isEqualTo: type)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((doc) {
        User user = User.fromMap(doc);
        users.add(user);
      });
    });

    return users.toList();
  }

  static Future<String> getDriverName(String driverId) async {
    String name = "a driver will contact you soon,sorry for the delay";
    await firestore
        .collection('users')
        .where("id", isEqualTo: driverId)
        .getDocuments()
        .then((snapshot) {
      if (snapshot.documents.isEmpty || snapshot.documents.length == 0) {
        return "a driver will contact you soon,sorry for the delay";
      }
      name = snapshot.documents[0]['name'];
      //print(snapshot.documents[0]['name']);
    });

    return name;
  }
}
