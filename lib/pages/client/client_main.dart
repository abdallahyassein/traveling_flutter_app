import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/ClientHelper.dart';
import 'package:mechanicscarfix/helper/MixHelper.dart';
import 'package:mechanicscarfix/pages/admin/completed_trip_details.dart';
import 'package:mechanicscarfix/pages/client/add_form.dart';
import 'package:mechanicscarfix/pages/client/form_client_page.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';
import 'package:mechanicscarfix/widgets/client_drawer.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ClientMainPage extends StatefulWidget {
  final String status;
  final String title;
  final String emptymessage;
  final String tileimage;
  final bool iseditable;

  ClientMainPage(this.status, this.title, this.emptymessage, this.tileimage,
      this.iseditable);
  @override
  _ClientMainPageState createState() => _ClientMainPageState();
}

class _ClientMainPageState extends State<ClientMainPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context, listen: false).getUserInf();

    final openIssues =
        ClientHelper.getClientIssues(userProvider.getId(), widget.status);

    return WillPopScope(
        onWillPop: () async => !widget.iseditable,
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(82, 82, 82, 1),
                ),
                drawer: ClientDrawer(),
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
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 50,
                              color: Color.fromRGBO(57, 57, 57, 1),
                              child: Center(
                                  child: Text(
                                widget.title,
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
                                  future: openIssues,
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
                                                style: GoogleFonts.aclonica(
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
                                                builder: (context) => ClientMainPage(
                                                    "open",
                                                    "Activity Page",
                                                    "We are  happy to help you",
                                                    "assets/images/problem_icon.png",
                                                    true))),
                                        child: ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (context, index) {
                                              String dateFromFirebase = snapshot
                                                  .data[index].createdAt;
                                              DateTime date = DateTime.parse(
                                                  dateFromFirebase);
                                              String dateAgo = timeago.format(
                                                  date,
                                                  locale: 'en_short');

                                              return Card(
                                                color: Color.fromRGBO(
                                                    82, 82, 82, 1),
                                                elevation: 2,
                                                child: ListTile(
                                                    subtitle: Text(
                                                      dateAgo,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                    ),
                                                    leading: Image.asset(
                                                        widget.tileimage),
                                                    title: Text(
                                                      snapshot
                                                          .data[index].details,
                                                      style:
                                                          GoogleFonts.openSans(
                                                        textStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      if (widget.iseditable ==
                                                          true) {
                                                        ClientHelper.getDriverDetails(
                                                                snapshot
                                                                    .data[index]
                                                                    .driverId)
                                                            .then((value) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      IssueClient(
                                                                          snapshot
                                                                              .data[index],
                                                                          value)));
                                                        });
                                                      } else {
                                                        ClientHelper.getDriverDetails(
                                                                snapshot
                                                                    .data[index]
                                                                    .driverId)
                                                            .then((value) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      CompletedTripPage(
                                                                          snapshot
                                                                              .data[index],
                                                                          value)));
                                                        });
                                                      }
                                                    },
                                                    trailing: IconButton(
                                                      icon: Icon(
                                                        Icons.delete_forever,
                                                        color: Colors.red,
                                                        size: 25,
                                                      ),
                                                      onPressed: () {
                                                        MixHelper.deleteForm(
                                                          snapshot
                                                              .data[index].id,
                                                          snapshot.data[index]
                                                              .mechanicId,
                                                        ).then((value) => Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => ClientMainPage(
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
                                                      },
                                                    )),
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
                floatingActionButton: FloatingActionButton(
                  child: Icon(
                    Icons.directions_car,
                    size: 40,
                  ),
                  backgroundColor: Color.fromRGBO(57, 57, 57, 1),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddIssueForm()));
                  },
                ))));
  }
}
