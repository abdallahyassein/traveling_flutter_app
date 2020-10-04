/* login page */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/DriverHelper.dart';

import 'package:mechanicscarfix/models/RequestForm.dart';
import 'package:mechanicscarfix/models/User.dart';
import 'package:mechanicscarfix/pages/client/client_details.dart';
import 'package:mechanicscarfix/pages/driver/problem_you_own.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';

class FormDetails extends StatefulWidget {
  final RequestForm form;
  final User client;

  FormDetails(this.form, this.client);
  @override
  _FormDetailsState createState() => _FormDetailsState();
}

class _FormDetailsState extends State<FormDetails> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // the key for the form
  TextEditingController price = new TextEditingController();
  bool isLoading = false;

  double rate = 1;

  @override
  Widget build(BuildContext context) {
    var dateCreatedParse = DateTime.parse(widget.form.createdAt);

    var formattedCreatedDate =
        "${dateCreatedParse.day}-${dateCreatedParse.month}-${dateCreatedParse.year}";

    print(formattedCreatedDate);

    var dateDriverParse = DateTime.parse(widget.form.timeDriverAccepted);

    var formatteddriverSumitedDate =
        "${dateDriverParse.day}-${dateDriverParse.month}-${dateDriverParse.year}";

    print(formatteddriverSumitedDate);

    var formattedFinishedDate = "Finish Date not Submited yet";
    if (widget.form.finishedAt != "") {
      var dateFinishedParse = DateTime.parse(widget.form.finishedAt);
      formattedFinishedDate =
          "${dateFinishedParse.day}-${dateFinishedParse.month}-${dateFinishedParse.year}";
    }

    print(formattedFinishedDate);

    _updatePrice() {
      if (_formKey.currentState.validate()) {
        setState(() {
          isLoading = true;
        });
        DriverHelper.setPrice(widget.form.id, price.text).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DriverTripsPage(
                      "open",
                      "UnCompleted Trips",
                      "There are no Uncompleted trips right now",
                      "assets/images/problem_icon.png")));
        });
      }
    }

    _submitUserRate() {
      DriverHelper.setClientRate(widget.form.id, widget.client.id, rate)
          .then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DriverTripsPage(
                    "open",
                    "UnCompleted Trips",
                    "There are no Uncompleted trips right now",
                    "assets/images/problem_icon.png")));
      });
    }

    return Scaffold(
      body: isLoading
          ? LoadingProgress()
          : SafeArea(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child: Text(
                            "Details",
                            style: GoogleFonts.antic(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
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
                                        widget.form.address,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.antic(
                                          textStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(82, 87, 112, 1),
                                          ),
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
                                            color:
                                                Color.fromRGBO(82, 87, 112, 1),
                                          ),
                                          fontSize: 25,
                                        ),
                                      ),
                                      Text(
                                        widget.form.phoneNumber,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.antic(
                                          textStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(82, 87, 112, 1),
                                          ),
                                          fontSize: 25,
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
                                        "Date You Submitted",
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
                                        formatteddriverSumitedDate,
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
                                        "Finish Date",
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
                                        formattedFinishedDate,
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
                                                    color: Colors.grey[200]))),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(79, 89, 101, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: Image.asset(
                                        'assets/images/client_icon.png'),
                                    title: Column(
                                      children: [
                                        Text(
                                          widget.client.name,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.client.address,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        RatingBar(
                                          ignoreGestures: true,
                                          initialRating:
                                              widget.client.rate.isEmpty
                                                  ? 0
                                                  : double.parse(
                                                      widget.client.rate,
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
                                                  ClientDetails(
                                                      widget.client)));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                widget.form.price == ""
                                    ? Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: TextFormField(
                                                controller: price,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onEditingComplete: () =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Please submit the price here",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    border: InputBorder.none),
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'please write the the price';
                                                  }
                                                  if (double.parse(value) <=
                                                      0) {
                                                    return 'please write the the price correctly';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              height: 50,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 50),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.green[300]),
                                              child: Center(
                                                child: FlatButton(
                                                    child: Text(
                                                      "Submit Price",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      _updatePrice();
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ))
                                    : Text(
                                        "Price : ${widget.form.price} \$ \n Payment Method : ${widget.form.paymentMethod}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.antic(
                                          textStyle: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                          fontSize: 25,
                                        ),
                                      ),
                                SizedBox(
                                  height: 20,
                                ),
                                widget.form.userRate == ""
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: RatingBar(
                                                initialRating:
                                                    widget.client.rate.isEmpty
                                                        ? 0
                                                        : double.parse(
                                                            widget.client.rate),
                                                minRating: 0,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  rate = rating;
                                                  print(rate);
                                                },
                                              )),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            height: 50,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 50),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.deepOrange[300]),
                                            child: Center(
                                              child: FlatButton(
                                                  child: Text(
                                                    "Submit rate for user",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    _submitUserRate();
                                                  }),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "User Rate",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.antic(
                                              textStyle: TextStyle(
                                                color: Colors.indigo,
                                              ),
                                              fontSize: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          RatingBar(
                                            initialRating: double.parse(
                                                widget.form.userRate),
                                            ignoreGestures: true,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          )
                                        ],
                                      ),
                                SizedBox(
                                  height: 20,
                                ),
                                widget.form.rate == ""
                                    ? Text(
                                        "there is no rate for trip until now",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.antic(
                                          textStyle: TextStyle(
                                            color: Colors.indigo,
                                          ),
                                          fontSize: 25,
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Text(
                                            "Issue Rate",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.antic(
                                              textStyle: TextStyle(
                                                color: Colors.indigo,
                                              ),
                                              fontSize: 25,
                                            ),
                                          ),
                                          RatingBar(
                                            initialRating:
                                                double.parse(widget.form.rate),
                                            ignoreGestures: true,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
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
                                      )
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
