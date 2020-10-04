import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/DriverHelper.dart';

import 'package:mechanicscarfix/pages/driver/form_details.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';

import 'package:mechanicscarfix/widgets/loading_progress.dart';
import 'package:mechanicscarfix/widgets/driver_drawer.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class DriverTripsPage extends StatefulWidget {
  final String status;
  final String title;
  final String emptymessage;
  final String tileimage;

  DriverTripsPage(
    this.status,
    this.title,
    this.emptymessage,
    this.tileimage,
  );
  @override
  _DriverTripsPageState createState() => _DriverTripsPageState();
}

class _DriverTripsPageState extends State<DriverTripsPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context, listen: false).getUserInf();

    final trips =
        DriverHelper.getDriverIssues(userProvider.getId(), widget.status);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(82, 82, 82, 1),
      ),
      drawer: MechanicDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/log_back.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Color.fromRGBO(57, 57, 57, 1),
                    child: Center(
                        child: Text(
                      widget.title,
                      style: GoogleFonts.antic(
                        textStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        fontSize: 35,
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(82, 82, 82, 0.6),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: FutureBuilder(
                        future: trips,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingProgress();
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              (!snapshot.hasData ||
                                  snapshot.data.length == 0)) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                  child: Text(widget.emptymessage,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.antic(
                                        textStyle: TextStyle(
                                            color: Colors.white, fontSize: 35),
                                      ))),
                            );
                          } else {
                            return RefreshIndicator(
                              onRefresh: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DriverTripsPage(
                                          "open",
                                          "Uncompleted Trips",
                                          "There are no uncompleted trips right now",
                                          "assets/images/problem_icon.png"))),
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    print(snapshot.data[index].details);
                                    String dateFromFirebase =
                                        snapshot.data[index].createdAt;
                                    DateTime date =
                                        DateTime.parse(dateFromFirebase);
                                    String dateAgo = timeago.format(date,
                                        locale: 'en_short');

                                    return Card(
                                      color: Color.fromRGBO(82, 82, 82, 1),
                                      elevation: 2,
                                      child: ListTile(
                                        subtitle: Text(
                                          dateAgo,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200),
                                        ),
                                        leading: Image.asset(widget.tileimage),
                                        title: Text(
                                          snapshot.data[index].details,
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          DriverHelper.getClientDetails(
                                                  snapshot.data[index].clientId)
                                              .then((value) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FormDetails(
                                                            snapshot
                                                                .data[index],
                                                            value)));
                                          });
                                        },
                                      ),
                                    );
                                  }),
                            );
                          }
                        })),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
