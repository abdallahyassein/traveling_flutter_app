/* login page */

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/ClientHelper.dart';
import 'package:mechanicscarfix/helper/MixHelper.dart';

import 'package:mechanicscarfix/models/Driver.dart';
import 'package:mechanicscarfix/models/RequestForm.dart';
import 'package:mechanicscarfix/pages/client/client_main.dart';
import 'package:mechanicscarfix/pages/driver/drivers_details.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';

class IssueClient extends StatefulWidget {
  final RequestForm form;
  final Driver driver;
  IssueClient(this.form, this.driver);
  @override
  _IssueClientState createState() => _IssueClientState();
}

class _IssueClientState extends State<IssueClient> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController feedback = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double formRate = 3;

    Driver driver = widget.driver;

    var dateCreatedParse = DateTime.parse(widget.form.createdAt);

    var formattedCreatedDate =
        "${dateCreatedParse.day}-${dateCreatedParse.month}-${dateCreatedParse.year}";

    var formatteddriverSubmitDate = "There is no driver submited the form yet";

    if (widget.form.timeDriverAccepted.isNotEmpty) {
      var driverSubmit = DateTime.parse(widget.form.timeDriverAccepted);

      formatteddriverSubmitDate =
          "${driverSubmit.day}-${driverSubmit.month}-${driverSubmit.year}";
    }

    showAlert(String title, String content, BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color.fromRGBO(103, 147, 203, 1),
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              content: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              actions: [
                FlatButton(
                  color: Colors.white,
                  child: Text(
                    "Ok",
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }

    _submitIssue() {
      if (widget.form.driverId.isEmpty) {
        showAlert("Alert",
            "We will send you a driver soon, Sorry for the delay", context);
        return;
      } else if (widget.form.price.isEmpty) {
        showAlert("Alert", "The price has not yet been determined", context);
      } else {
        if (!_formKey.currentState.validate()) {
          feedback.text = "";
        }

        ClientHelper.completeRequestForm(
          widget.form.id,
          widget.form.clientId,
          widget.form.driverId,
          formRate,
          widget.form.price,
          feedback.text,
        ).then((value) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientMainPage(
                    "open",
                    "Activity Page",
                    "We are happy to help you",
                    "assets/images/problem_icon.png",
                    true))));
      }
    }

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? LoadingProgress()
            : Container(
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
                            "Form Details",
                            style: GoogleFonts.aclonica(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              fontSize: 40,
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
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          widget.form.details,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.actor(
                                            textStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    82, 87, 112, 1),
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
                                              color: Color.fromRGBO(
                                                  82, 87, 112, 1),
                                            ),
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          widget.form.phoneNumber,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.antic(
                                            textStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  82, 87, 112, 1),
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
                                              color: Color.fromRGBO(
                                                  103, 121, 203, 1),
                                            ),
                                            fontSize: 19,
                                          ),
                                        ),
                                        Text(
                                          formattedCreatedDate,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.timmana(
                                            textStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  103, 121, 203, 1),
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
                                              color: Color.fromRGBO(
                                                  103, 121, 203, 1),
                                            ),
                                            fontSize: 19,
                                          ),
                                        ),
                                        Text(
                                          formatteddriverSubmitDate,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.timmana(
                                            textStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  103, 121, 203, 1),
                                            ),
                                            fontSize: 17,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            controller: feedback,
                                            maxLines: 4,
                                            keyboardType:
                                                TextInputType.multiline,
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .unfocus(),
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Please write your feedback about the service",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'please fill the data';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
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
                                          ignoreGestures: true,
                                          unratedColor: Colors.grey,
                                          initialRating: double.parse(
                                            driver.rate,
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
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DriverDetails(
                                                      widget.driver)));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Divider(
                                  //color: Colors.black,

                                  thickness: 1,
                                  endIndent: 0,
                                ),
                                SizedBox(
                                  height: 10,
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
                                RatingBar(
                                  unratedColor: Colors.grey,
                                  initialRating: 3,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    formRate = rating;
                                    print(formRate);
                                  },
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromRGBO(91, 142, 207, 1)),
                                  child: Center(
                                    child: FlatButton(
                                        child: Text(
                                          "Finish",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          _submitIssue();
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                widget.form.price == ""
                                    ? Container(
                                        height: 50,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 40),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.redAccent),
                                        child: Center(
                                          child: FlatButton(
                                              child: Text(
                                                "Failed",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                MixHelper.deleteForm(
                                                  widget.form.id,
                                                  widget.form.driverId,
                                                ).then((value) => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ClientMainPage(
                                                                "open",
                                                                "Activity Page",
                                                                "We are happy to help you",
                                                                "assets/images/problem_icon.png",
                                                                true))));
                                              }),
                                        ),
                                      )
                                    : Text(""),
                                SizedBox(
                                  height: 20,
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
