import 'package:flutter/material.dart';

import 'package:mechanicscarfix/pages/admin/admin_main.dart';
import 'package:mechanicscarfix/pages/admin/all_admins.dart';
import 'package:mechanicscarfix/pages/admin/all_clients.dart';

import 'package:mechanicscarfix/pages/admin/all_drivers.dart';

import 'package:mechanicscarfix/pages/admin/complaints_page.dart';
import 'package:mechanicscarfix/pages/admin/register_user.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';
import 'package:mechanicscarfix/widgets/drawer_header.dart';
import 'package:mechanicscarfix/widgets/simple_tile.dart';
import 'package:provider/provider.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHead('assets/images/admin_icon.png'),
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
                      builder: (context) => AdminMainPage(
                          "open",
                          "Main Admin Page",
                          "There is no trips right now",
                          "assets/images/problem_icon.png",
                          false)));
            },
          ),
          SizedBox(
            height: 15,
          ),
          SimpleTile('Completed Trips', 'assets/images/solver_icon.png', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminMainPage(
                        "finish",
                        "Completed Trips",
                        "There are no trips yet",
                        "assets/images/solver_icon.png",
                        true)));
          }),
          SizedBox(
            height: 15,
          ),
          SimpleTile('Clients', 'assets/images/client_icon.png', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllClientsPage(
                        "client",
                        "All Clients",
                        "There are no Clients until now",
                        "assets/images/client_icon.png")));
          }),
          SizedBox(
            height: 15,
          ),
          SimpleTile('Admins', 'assets/images/admin_icon.png', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllAdminsPage(
                        "admin",
                        "All Admins",
                        "There are no Admins until now",
                        "assets/images/admin_icon.png")));
          }),
          SizedBox(
            height: 15,
          ),
          SimpleTile('Drivers', 'assets/images/mechanic_icon.png', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllDriversPage(
                        "All Drivers",
                        "There are no Drivers Working with you right now",
                        "assets/images/mechanic_icon.png")));
          }),
          SizedBox(
            height: 15,
          ),
          SimpleTile('Add Users', 'assets/images/add_user.png', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterUser()));
          }),
          SizedBox(
            height: 15,
          ),
          SimpleTile('Complaints', 'assets/images/issue_form.png', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ComplaintsPage()));
          }),
          SizedBox(
            height: 15,
          ),
          SimpleTile('Log out', 'assets/images/log_out_icon.png', () {
            Provider.of<UserProvider>(context, listen: false).logOut(context);
          }),
        ],
      ),
    );
  }
}
