/* login page */

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/DriverHelper.dart';
import 'package:mechanicscarfix/models/RequestForm.dart';
import 'package:mechanicscarfix/models/User.dart';
import 'package:mechanicscarfix/pages/client/client_details.dart';
import 'package:mechanicscarfix/pages/driver/driver_main.dart';
import 'package:mechanicscarfix/pages/driver/problem_you_own.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';
import 'package:provider/provider.dart';

class IssueCheckPage extends StatefulWidget {
  final RequestForm form;
  final User user;

  IssueCheckPage(this.form, this.user);
  @override
  _IssueCheckPageState createState() => _IssueCheckPageState();
}

class _IssueCheckPageState extends State<IssueCheckPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context, listen: false).getUserInf();

    _acceptInvitation() {
      setState(() {
        _isLoading = true;
      });

      DriverHelper.acceptInvitation(userProvider.getId(), widget.form.id)
          .then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DriverTripsPage(
                    "open",
                    "Uncompleted Trips",
                    "There are no trips right now",
                    "assets/images/problem_icon.png")));
      });
    }

    _refuseInvitation() {
      setState(() {
        _isLoading = true;
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DriverMainPage()));
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
                            "Issue Details",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.antic(
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
                                Card(
                                  color: Color.fromRGBO(82, 82, 82, 1),
                                  elevation: 2,
                                  child: ListTile(
                                    leading: Image.asset(
                                        'assets/images/client_icon.png'),
                                    title: Column(
                                      children: [
                                        Text(
                                          widget.user.name,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.user.address,
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
                                              widget.user.rate.isEmpty
                                                  ? 0
                                                  : double.parse(
                                                      widget.user.rate,
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
                                                  ClientDetails(widget.user)));
                                    },
                                  ),
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
                                          "Accept",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          _acceptInvitation();
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.redAccent),
                                  child: Center(
                                    child: FlatButton(
                                        child: Text(
                                          "Refuse",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          _refuseInvitation();
                                        }),
                                  ),
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
