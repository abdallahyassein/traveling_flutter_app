import 'package:flutter/material.dart';
import 'package:mechanicscarfix/pages/client/client_main.dart';
import 'package:mechanicscarfix/pages/client/submit_complaint.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';
import 'package:mechanicscarfix/widgets/drawer_header.dart';
import 'package:mechanicscarfix/widgets/simple_tile.dart';
import 'package:provider/provider.dart';

class ClientDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHead('assets/images/client_icon.png'),
          SizedBox(
            height: 15,
          ),
          SimpleTile(
            "UnCompleted Trips",
            'assets/images/problem_icon.png',
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientMainPage(
                          "open",
                          "Activity Page",
                          "If you have any trips.We will be happy to help",
                          "assets/images/problem_icon.png",
                          true)));
            },
          ),
          SizedBox(
            height: 15,
          ),
          SimpleTile(
            "Completed Trips",
            'assets/images/solver_icon.png',
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientMainPage(
                          "finish",
                          "Completed Trips",
                          "There are no trips yet",
                          "assets/images/solver_icon.png",
                          false)));
            },
          ),
          SizedBox(
            height: 15,
          ),
          SimpleTile(
            'Submit a complaint',
            'assets/images/issue_form.png',
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubmitComplaint()));
            },
          ),
          SizedBox(
            height: 15,
          ),
          SimpleTile(
            'Log out',
            'assets/images/log_out_icon.png',
            () {
              Provider.of<UserProvider>(context, listen: false).logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
