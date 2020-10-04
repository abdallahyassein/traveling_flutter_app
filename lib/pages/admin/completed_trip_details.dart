/* login page */

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:mechanicscarfix/models/RequestForm.dart';
import 'package:mechanicscarfix/models/Driver.dart';
import 'package:mechanicscarfix/pages/driver/drivers_details.dart';

class CompletedTripPage extends StatefulWidget {
  final RequestForm form;
  final Driver driver;
  CompletedTripPage(this.form, this.driver);
  @override
  _CompletedTripPageState createState() => _CompletedTripPageState();
}

class _CompletedTripPageState extends State<CompletedTripPage> {
  @override
  Widget build(BuildContext context) {
    Driver driver = widget.driver;

    var dateCreatedParse = DateTime.parse(widget.form.createdAt);

    var formattedCreatedDate =
        "${dateCreatedParse.day}-${dateCreatedParse.month}-${dateCreatedParse.year}";

    var formattedFinishedDate = "The Finish Date Not Submited Yet";
    if (widget.form.finishedAt.isNotEmpty) {
      var dateFinishedParse = DateTime.parse(widget.form.finishedAt);
      formattedFinishedDate =
          "${dateFinishedParse.day}-${dateFinishedParse.month}-${dateFinishedParse.year}";
    }

    var formatteddriverSubmitDate = "There is no driver submited the form yet";

    if (widget.form.timeDriverAccepted.isNotEmpty) {
      var driverSubmit = DateTime.parse(widget.form.timeDriverAccepted);

      formatteddriverSubmitDate =
          "${driverSubmit.day}-${driverSubmit.month}-${driverSubmit.year}";
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Text(
                      "Trip Details",
                      style: GoogleFonts.aclonica(
                        textStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        fontSize: 45,
                      ),
                    )),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  widget.form.details,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.actor(
                                    textStyle: TextStyle(
                                        color: Color.fromRGBO(82, 87, 112, 1),
                                        fontWeight: FontWeight.bold),
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.form.carType,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.antic(
                                    textStyle: TextStyle(
                                      color: Color.fromRGBO(82, 87, 112, 1),
                                    ),
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  widget.form.phoneNumber,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.antic(
                                    textStyle: TextStyle(
                                      color: Color.fromRGBO(82, 87, 112, 1),
                                    ),
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Start Date",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.timmana(
                                    textStyle: TextStyle(
                                      color: Color.fromRGBO(103, 121, 203, 1),
                                    ),
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  formattedCreatedDate,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.timmana(
                                    textStyle: TextStyle(
                                      color: Color.fromRGBO(103, 121, 203, 1),
                                    ),
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Driver Submit Date",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.timmana(
                                    textStyle: TextStyle(
                                      color: Color.fromRGBO(103, 121, 203, 1),
                                    ),
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  formatteddriverSubmitDate,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.timmana(
                                    textStyle: TextStyle(
                                      color: Color.fromRGBO(103, 121, 203, 1),
                                    ),
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Finish Date",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.timmana(
                                    textStyle: TextStyle(
                                      color: Color.fromRGBO(103, 121, 203, 1),
                                    ),
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  formattedFinishedDate,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.timmana(
                                    textStyle: TextStyle(
                                      color: Color.fromRGBO(103, 121, 203, 1),
                                    ),
                                    fontSize: 17,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(79, 89, 101, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                  "assets/images/mechanic_icon.png"),
                              title: Column(
                                children: [
                                  Text(
                                    driver.name,
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
                                      driver.rate,
                                    ),
                                    minRating: 0,
                                    itemSize: 20,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DriverDetails(widget.driver)));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.form.price == ""
                                ? "Price : The price has not yet been determined "
                                : "Price : ${widget.form.price} N\$ \n Payment Method : ${widget.form.paymentMethod}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.abel(
                              textStyle: TextStyle(
                                  color: Colors.green[300],
                                  fontWeight: FontWeight.bold),
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          widget.form.rate == ""
                              ? Text(
                                  "there is no rate until now",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.antic(
                                    textStyle: TextStyle(
                                      color: Colors.indigo,
                                    ),
                                    fontSize: 25,
                                  ),
                                )
                              : RatingBar(
                                  ignoreGestures: true,
                                  initialRating: double.parse(widget.form.rate),
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
