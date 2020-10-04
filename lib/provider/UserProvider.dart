import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanicscarfix/models/User.dart';
import 'package:mechanicscarfix/pages/admin/admin_main.dart';
import 'package:mechanicscarfix/pages/client/client_main.dart';
import 'package:mechanicscarfix/pages/login_page.dart';
import 'package:mechanicscarfix/pages/driver/driver_main.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class UserProvider extends ChangeNotifier {
  User _user;

  User getUserInf() {
    return _user;
  }

  setUserInf(User user) {
    _user = user;
    print(_user);
    notifyListeners();
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('please insert right credintionals.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        );
      },
    );
  }

  Future loginUser(String email, String password, BuildContext context) async {
    Firestore firestore = Firestore.instance;

    try {
      FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      print(user.email);
      firestore
          .collection('users')
          .where("email", isEqualTo: user.email)
          .snapshots()
          .listen((data) {
        data.documents.forEach((doc) {
          setUserInf(User.fromMap(doc));

          if (doc["type"] == "driver") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DriverMainPage()));

            print('GO To Driver Page');
          } else if (doc["type"] == "admin") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminMainPage(
                        "open",
                        "Main Admin Page",
                        "There is no problems right now",
                        "assets/images/problem_icon.png",
                        false)));

            print('GO To Admin Page');
          } else {
            //  Provider.of<ClientProvider>(context,listen: false).getClientOpenedIssues(getUserInf().getId());

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClientMainPage(
                        "open",
                        "Activity Page",
                        "If you have any trips.We will be happy to help",
                        "assets/images/problem_icon.png",
                        true)));
            print('GO To Client Page');
          }
        });
      });
    } catch (e) {
      print("There is A Problem");

      _showMyDialog(context);
    }
  }

  Future logOut(BuildContext context) async {
    await auth.signOut();
    setUserInf(new User("", "", "", "", "", "", "", ""));
    print("log out");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
