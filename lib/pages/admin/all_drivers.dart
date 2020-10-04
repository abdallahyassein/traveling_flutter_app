import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/AdminHelper.dart';
import 'package:mechanicscarfix/pages/driver/drivers_details.dart';
import 'package:mechanicscarfix/widgets/admin_drawer.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AllDriversPage extends StatefulWidget {
  final String title;
  final String emptymessage;
  final String tileimage;

  AllDriversPage(
    this.title,
    this.emptymessage,
    this.tileimage,
  );
  @override
  _AllDriversPageState createState() => _AllDriversPageState();
}

class _AllDriversPageState extends State<AllDriversPage> {
  @override
  Widget build(BuildContext context) {
    final mechanics = AdminHelper.getAllDriversWorking();

    return SafeArea(
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
                    color: Color.fromRGBO(57, 57, 57, 1),
                    child: Center(
                        child: Text(
                      widget.title,
                      style: GoogleFonts.aclonica(
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
                                    color: Color.fromRGBO(82, 82, 82, 1),
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
                                            unratedColor: Colors.grey,
                                            ignoreGestures: true,
                                            initialRating: double.parse(
                                              snapshot.data[index].rate,
                                            ),
                                            minRating: 0,
                                            itemSize: 20,
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
                                          Text(
                                            snapshot.data[index].status,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                fontSize: 17,
                                                color: snapshot.data[index]
                                                            .status ==
                                                        "free"
                                                    ? Colors.greenAccent
                                                    : Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          AdminHelper.deleteDriver(
                                                  snapshot.data[index].id)
                                              .then((value) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AllDriversPage(
                                                            "All Drivers",
                                                            "There is no Drivers Working with you right now",
                                                            "assets/images/mechanic_icon.png")));
                                          });
                                        },
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DriverDetails(
                                                        snapshot.data[index])));
                                      },
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
