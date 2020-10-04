import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanicscarfix/helper/MixHelper.dart';
import 'package:mechanicscarfix/models/Invitation.dart';
import 'package:mechanicscarfix/models/RequestForm.dart';
import 'package:mechanicscarfix/models/User.dart';

Firestore firestore = Firestore.instance;

class DriverHelper {
  static Future<List<RequestForm>> getDriverIssues(
      driverId, String status) async {
    List<RequestForm> issues = [];

    await firestore
        .collection('issues')
        .where("driverId", isEqualTo: driverId)
        .where("status", isEqualTo: status)
        .limit(10)
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((doc) {
        RequestForm issue = RequestForm.fromMap(doc);
        //  print(issue.rate);
        issues.add(issue);
      });
    });
    print(issues);
    return issues.toList();
  }

  static Future<List<Invitation>> getDriverInvitations(driverId) async {
    List<Invitation> invitations = [];

    await firestore
        .collection('invitations')
        .where("driverId", isEqualTo: driverId)
        .getDocuments()
        .then((snapshot) {
      Invitation invit = Invitation(
          id: snapshot.documents[0]["id"],
          clientId: snapshot.documents[0]["clientId"],
          issueId: snapshot.documents[0]["issueId"],
          driverId: snapshot.documents[0]["driverId"]);

      invitations.add(invit);
    });

    return invitations.toList();
  }

  static Future<RequestForm> getFormInfo(String issueId) async {
    RequestForm issueForm = new RequestForm();

    await firestore
        .collection('issues')
        .where("id", isEqualTo: issueId)
        .getDocuments()
        .then((snapshot) {
      if (snapshot.documents.isEmpty || snapshot.documents.length == 0) {
        return "There is no Trips";
      }

      issueForm = RequestForm.fromMap(snapshot.documents[0]);
    });

    return issueForm;
  }

  // static Future<Map<String, IssueForm>> getInvitationsDetails(
  //     driverId) async {
  //   Map<String, IssueForm> alldetails = Map<String, IssueForm>();

  //   final invitation = await getMechanicInvitations(driverId);
  //   final issue = await getIssueInfo(invitation[0].issueId);

  //   alldetails.putIfAbsent(invitation[0].id, () => issue);

  //   return alldetails;
  // }

  static Future<User> getClientDetails(String clientId) async {
    User client =
        new User("", "This Client is Not With Us now", "", "0", "", "", "", "");
    await firestore
        .collection('users')
        .where("id", isEqualTo: clientId)
        .getDocuments()
        .then((snapshot) {
      if (snapshot.documents.isEmpty || snapshot.documents.length == 0) {
        //return "a driver will contact you soon,sorry for the delay";
      } else {
        client = User.fromMap(snapshot.documents[0]);
      }

      //print(snapshot.documents[0]['name']);
    });

    return client;
  }

  static Future<List<RequestForm>> getAllOpenIssues() async {
    List<RequestForm> issues = [];

    await firestore
        .collection('issues')
        .where("driverId", isEqualTo: "")
        .where("status", isEqualTo: "open")
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((doc) {
        RequestForm issue = RequestForm.fromMap(doc);
        issues.add(issue);
      });
    });

    return issues.toList();
  }

  static Future acceptInvitation(String driverId, String issueId) async {
    await firestore
        .collection('issues')
        .where("id", isEqualTo: issueId)
        .where("driverId", isEqualTo: "")
        .getDocuments()
        .then((snapshot) {
      print(snapshot.documents);

      snapshot.documents.first.reference.updateData({
        "driverId": driverId,
        "timeDriverAccepted": DateTime.now().toString(),
      }).then((value) {});
    });

    MixHelper.updateStatus(driverId, "busy");
  }

  // static Future refuseInvitation(
  //     String invitationsId, String driverId) async {
  //   await MixHelper.updateStatus(driverId, "free");

  //   await firestore
  //       .collection('invitations')
  //       .where("id", isEqualTo: invitationsId)
  //       .getDocuments()
  //       .then((snapshot) {
  //     for (DocumentSnapshot doc in snapshot.documents) {
  //       doc.reference.delete();
  //     }
  //   });
  // }

  static Future setPrice(String issueId, String price) async {
    await firestore
        .collection('issues')
        .where("id", isEqualTo: issueId)
        .getDocuments()
        .then((snapshot) {
      print(snapshot.documents);

      snapshot.documents.first.reference.updateData({
        "price": price,
      });
    });
  }

  static Future createRate(double rate, String clientId) async {
    await firestore.collection('rates').document().setData({
      'rate': rate.toString(),
      'clientId': clientId,
      'feedback': "",
    });
  }

  static setClientRate(String issueId, String clientId, double rate) async {
    double totalRate = 0;
    double numberofRates = 0;

    await createRate(rate, clientId).then((value) {
      firestore
          .collection('rates')
          .where("clientId", isEqualTo: clientId)
          .snapshots()
          .listen((data) => data.documents.forEach((doc) {
                totalRate += double.parse(doc['rate']);
                numberofRates++;
              }));

      firestore
          .collection('issues')
          .where("id", isEqualTo: issueId)
          .getDocuments()
          .then((snapshot) {
        snapshot.documents.first.reference.updateData({
          "userRate": rate.toString(),
        });
      });

      firestore
          .collection('users')
          .where("id", isEqualTo: clientId)
          .getDocuments()
          .then((snapshot) {
        //print("Found it");
        snapshot.documents.first.reference.updateData({
          "rate": (totalRate / numberofRates).round().toString(),
        });
      });
    });
  }
}
