import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/AdminHelper.dart';
import 'package:mechanicscarfix/pages/admin/admin_main.dart';
import 'package:mechanicscarfix/widgets/admin_drawer.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DriverPage extends StatefulWidget {
  final String issueId;
  final String clientId;
  final String status;
  final String title;
  final String emptymessage;
  final String tileimage;

  DriverPage(
    this.issueId,
    this.clientId,
    this.status,
    this.title,
    this.emptymessage,
    this.tileimage,
  );
  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  @override
  Widget build(BuildContext context) {
    final mechanics = AdminHelper.getAllDrivers("free");

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(103, 147, 203, 1),
      ),
      drawer: AdminDrawer(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromRGBO(103, 147, 203, 1),
          Color.fromRGBO(103, 121, 203, 1),
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                      child: Text(
                    widget.title,
                    style: GoogleFonts.antic(
                      textStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      fontSize: 35,
                    ),
                  )),
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
                  color: Colors.white,
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: FutureBuilder(
                        future: mechanics,
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
                                            color: Color.fromRGBO(
                                                103, 147, 203, 1),
                                            fontSize: 35),
                                      ))),
                            );
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Color.fromRGBO(103, 147, 203, 1),
                                    elevation: 2,
                                    child: ListTile(
                                      leading: Image.asset(widget.tileimage),
                                      title: Column(
                                        children: [
                                          Text(
                                            snapshot.data[index].name,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          RatingBar(
                                            ignoreGestures: true,
                                            initialRating: double.parse(
                                              snapshot.data[index].rate,
                                            ),
                                            minRating: 0,
                                            itemSize: 25,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          ),
                                        ],
                                      ),
                                      trailing: InkWell(
                                        child: Image.asset(
                                          "assets/images/messages_icon.png",
                                          height: 50,
                                          width: 50,
                                        ),
                                        onTap: () {
                                          AdminHelper.sendInvitation(
                                                  widget.issueId,
                                                  snapshot.data[index].id,
                                                  widget.clientId)
                                              .then((value) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AdminMainPage(
                                                        "open",
                                                        "Main Admin Page",
                                                        "There is no problems right now",
                                                        "assets/images/add_user.png",
                                                        false)));
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                });
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
