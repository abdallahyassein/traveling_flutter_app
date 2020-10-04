import 'package:flutter/material.dart';
import 'package:mechanicscarfix/pages/driver/driver_main.dart';
import 'package:mechanicscarfix/pages/driver/problem_you_own.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';
import 'package:mechanicscarfix/widgets/drawer_header.dart';
import 'package:mechanicscarfix/widgets/simple_tile.dart';
import 'package:provider/provider.dart';

class MechanicDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHead('assets/images/mechanic_icon.png'),
          SizedBox(
            height: 15,
          ),
          SimpleTile(
            'Invitations',
            'assets/images/messages_icon.png',
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DriverMainPage()));
            },
          ),
          SizedBox(
            height: 15,
          ),
          SimpleTile(
            'UnCompleted Trips',
            'assets/images/problem_icon.png',
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DriverTripsPage(
                          "open",
                          "UnCompleted Trips",
                          "There are no uncompleted trips right now",
                          "assets/images/problem_icon.png")));
            },
          ),
          SizedBox(
            height: 15,
          ),
          SimpleTile(
            'Completed Trips',
            'assets/images/solver_icon.png',
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DriverTripsPage(
                          "finish",
                          "Completed Trips",
                          "There are no completed trips right now",
                          "assets/images/solver_icon.png")));
            },
          ),
          SizedBox(
            height: 15,
          ),
          SimpleTile(
            'Log Out',
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
