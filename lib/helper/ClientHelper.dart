import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanicscarfix/helper/MixHelper.dart';
import 'package:mechanicscarfix/models/RequestForm.dart';
import 'package:mechanicscarfix/models/Driver.dart';

Firestore firestore = Firestore.instance;

class ClientHelper {
  static Future<List<RequestForm>> getClientIssues(
      clientId, String status) async {
    List<RequestForm> issues = [];

    await firestore
        .collection('issues')
        .where("clientId", isEqualTo: clientId)
        .limit(10)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((doc) {
        if (doc['status'] == status) {
          RequestForm issue = RequestForm.fromMap(doc);
          issues.add(issue);
        }
      });
    });

    return issues.toList();
  }

  static Future addIssueForm(RequestForm form) async {
    await firestore.collection('issues').document().setData(form.toMap());
  }

  static Future completeRequestForm(
    String issueId,
    String clientId,
    String driverId,
    double rate,
    String price,
    String feedback,
  ) async {
    await firestore
        .collection('issues')
        .where("id", isEqualTo: issueId)
        .where("clientId", isEqualTo: clientId)
        .where("driverId", isEqualTo: driverId)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.first.reference.updateData({
        "finishedAt": DateTime.now().toString(),
        "status": "finish",
        "rate": rate.toString(),
      });

      createRate(rate, driverId, feedback);
      setDriverRate(driverId, rate);
      MixHelper.updateStatus(driverId, "free");
    });
  }

  static setDriverRate(String driverId, double rate) async {
    double totalRate = 0;
    double numberofRates = 0;

    firestore
        .collection('rates')
        .where("driverId", isEqualTo: driverId)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              totalRate += double.parse(doc['rate']);
              numberofRates++;
            }));

    await firestore
        .collection('users')
        .where("id", isEqualTo: driverId)
        .getDocuments()
        .then((snapshot) {
      //print("Found it");
      snapshot.documents.first.reference.updateData({
        "rate": (totalRate / numberofRates).round().toString(),
      });
    });
  }

  static createRate(double rate, String driverId, String feedback) async {
    await firestore.collection('rates').document().setData({
      'rate': rate.toString(),
      'driverId': driverId,
      'feedback': feedback,
    });
  }

  static Future<String> getMechanicName(String driverId) async {
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

  static Future<Driver> getDriverDetails(String driverId) async {
    Driver driver = new Driver("", "", "", "", "", "", "", "0", "");
    await firestore
        .collection('users')
        .where("id", isEqualTo: driverId)
        .getDocuments()
        .then((snapshot) {
      if (snapshot.documents.isEmpty || snapshot.documents.length == 0) {
        //return "a driver will contact you soon,sorry for the delay";
      } else {
        driver = Driver.fromMap(snapshot.documents[0]);
      }
      //print(snapshot.documents[0]['name']);
    });

    return driver;
  }

  static Future submitComplaint(String clientId, String feedback) async {
    await firestore.collection('complaints').document().setData({
      'clientId': clientId,
      'feedback': feedback,
    });
  }
}
