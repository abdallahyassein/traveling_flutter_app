import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechanicscarfix/helper/MixHelper.dart';
import 'package:mechanicscarfix/models/Complaint.dart';
import 'package:mechanicscarfix/models/RequestForm.dart';
import 'package:mechanicscarfix/models/Driver.dart';
import 'package:mechanicscarfix/models/User.dart';
import 'package:uuid/uuid.dart';

Firestore firestore = Firestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class AdminHelper {
  static Future<bool> registerUser(User user) async {
    Firestore saveData = Firestore.instance;
    bool succeeded = false;

    try {
      await auth.createUserWithEmailAndPassword(
          email: user.getEmail(), password: user.getPassword());
      succeeded = true;
    } catch (e) {
      succeeded = false;
      print("There is A Problem");
    }
    try {
      if (succeeded) {
        auth.currentUser().then((value) {
          if (user.type == 'driver') {
            saveData
                .collection('users')
                .document()
                .setData(user.toMapDriver(value.uid));
          } else {
            saveData
                .collection('users')
                .document()
                .setData(user.toMap(value.uid));
          }
        });
      }
    } catch (e) {
      print("There is A Problem");
    }

    return succeeded;
  }

  static Future<List<RequestForm>> getAllIssues(String status) async {
    List<RequestForm> issues = [];

    await firestore.collection('issues').getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        if (doc['status'] == status) {
          RequestForm issue = RequestForm.fromMap(doc);
          issues.add(issue);
        }
      });
    });

    return issues.toList();
  }

  static Future<List<Driver>> getAllDrivers(String status) async {
    List<Driver> drivers = [];

    await firestore
        .collection('users')
        .orderBy("rate", descending: true)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((doc) {
        if (doc['type'] == 'driver' && doc['status'] == status) {
          Driver user = Driver.fromMap(doc);
          drivers.add(user);
        }
      });
    });

    return drivers.toList();
  }

  static Future<List<Driver>> getAllDriversWorking() async {
    List<Driver> drivers = [];

    await firestore
        .collection('users')
        .orderBy("rate", descending: true)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((doc) {
        if (doc['type'] == 'driver') {
          Driver user = Driver.fromMap(doc);
          drivers.add(user);
        }
      });
    });

    return drivers.toList();
  }

  static Future<List<Complaint>> getAllComplaints() async {
    List<Complaint> complaints = [];

    await firestore.collection('complaints').getDocuments().then((snapshot) {
      snapshot.documents.forEach((doc) {
        Complaint issue = Complaint.fromMap(doc);
        complaints.add(issue);
      });
    });

    return complaints.toList();
  }

  static Future deleteComplaint(
    String clientId,
    String feedback,
  ) async {
    await firestore
        .collection('complaints')
        .where("clientId", isEqualTo: clientId)
        .where("feedback", isEqualTo: feedback)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.first.reference.delete();
    });
  }

  static Future deleteAdmin(
    String adminId,
  ) async {
    await firestore
        .collection('users')
        .where("id", isEqualTo: adminId)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.first.reference.delete();
    });
  }

  static Future deleteClient(
    String clientId,
  ) async {
    await firestore
        .collection('users')
        .where("id", isEqualTo: clientId)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.first.reference.delete();

      firestore
          .collection('issues')
          .where("clientId", isEqualTo: clientId)
          .where("status", isEqualTo: "open")
          .getDocuments()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.documents) {
          if (doc["driverId"] != "") {
            MixHelper.updateStatus(doc['driver'], "free");
          }

          doc.reference.delete();
        }
      });
    });
  }

  static Future deleteDriver(String driverId) async {
    await firestore
        .collection('users')
        .where("id", isEqualTo: driverId)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.first.reference.delete();
    }).then((value) {
      firestore
          .collection('issues')
          .where("driverId", isEqualTo: driverId)
          .getDocuments()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.documents) {
          doc.reference.updateData({
            "driverId": "",
          });
        }
      });
    });
  }

  static Future sendInvitation(
      String issueId, String driverId, String clientId) async {
    await firestore
        .collection('invitations')
        .where("issueId", isEqualTo: issueId)
        .where("driverId", isEqualTo: driverId)
        .where("clientId", isEqualTo: clientId)
        .getDocuments()
        .then((snapshot) {
      if (snapshot.documents.isEmpty || snapshot.documents.length == 0) {
        var uuid = Uuid();

        firestore.collection('invitations').document().setData({
          "id": uuid.v4(),
          'issueId': issueId,
          'driverId': driverId,
          'clientId': clientId,
        }).then((value) {
          MixHelper.updateStatus(driverId, "busy");
        });
      }
    });
  }
}
