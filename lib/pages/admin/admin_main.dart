import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/AdminHelper.dart';
import 'package:mechanicscarfix/helper/ClientHelper.dart';
import 'package:mechanicscarfix/helper/MixHelper.dart';
import 'package:mechanicscarfix/pages/admin/completed_trip_details.dart';
import 'package:mechanicscarfix/widgets/admin_drawer.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdminMainPage extends StatefulWidget {
  final String status;
  final String title;
  final String emptymessage;
  final String tileimage;
  final bool iseditable;

  AdminMainPage(this.status, this.title, this.emptymessage, this.tileimage,
      this.iseditable);
  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    final issues = AdminHelper.getAllIssues(widget.status);

    return WillPopScope(
        onWillPop: () async => !widget.iseditable,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromRGBO(82, 82, 82, 1),
          ),
          drawer: AdminDrawer(),
          body: Container(
            width: double.infinity,
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
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aclonica(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                            future: issues,
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
                                                color: Colors.white,
                                                fontSize: 35),
                                          ))),
                                );
                              } else {
                                return RefreshIndicator(
                                  onRefresh: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminMainPage(
                                              "open",
                                              "Main Admin Page",
                                              "There are no trips right now",
                                              "assets/images/problem_icon.png",
                                              false))),
                                  child: ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
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
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                              leading:
                                                  Image.asset(widget.tileimage),
                                              title: Text(
                                                snapshot.data[index].details,
                                                style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                ClientHelper.getDriverDetails(
                                                        snapshot.data[index]
                                                            .driverId)
                                                    .then((value) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CompletedTripPage(
                                                                  snapshot.data[
                                                                      index],
                                                                  value)));
                                                });
                                              },
                                              trailing: IconButton(
                                                  icon: Icon(
                                                    Icons.delete_forever,
                                                    color: Colors.red,
                                                    size: 25,
                                                  ),
                                                  onPressed: () {
                                                    MixHelper.deleteForm(
                                                      snapshot.data[index].id,
                                                      snapshot
                                                          .data[index].driverId,
                                                    ).then((value) => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AdminMainPage(
                                                                    widget
                                                                        .status,
                                                                    widget
                                                                        .title,
                                                                    widget
                                                                        .emptymessage,
                                                                    widget
                                                                        .tileimage,
                                                                    widget
                                                                        .iseditable))));
                                                  })),
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
        )));
  }
}
