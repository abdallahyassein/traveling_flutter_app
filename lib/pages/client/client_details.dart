/* login page */

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/models/User.dart';

class ClientDetails extends StatefulWidget {
  final User client;

  ClientDetails(this.client);
  @override
  _ClientDetailsState createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  @override
  Widget build(BuildContext context) {
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
                      "Client Details",
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
                            height: 40,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  widget.client.name,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.actor(
                                    textStyle: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold),
                                    fontSize: 25,
                                  ),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.client.address,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.antic(
                                    textStyle: TextStyle(
                                      color: Colors.indigo,
                                    ),
                                    fontSize: 25,
                                  ),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.client.phone,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.antic(
                                    textStyle: TextStyle(
                                      color: Colors.indigo,
                                    ),
                                    fontSize: 25,
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
                            unratedColor: Colors.grey,
                            initialRating: widget.client.rate.isEmpty
                                ? 0
                                : double.parse(widget.client.rate),
                            ignoreGestures: true,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
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
