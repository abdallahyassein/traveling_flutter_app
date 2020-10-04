/* login page */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/ClientHelper.dart';
import 'package:mechanicscarfix/pages/client/client_main.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';
import 'package:mechanicscarfix/widgets/client_drawer.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';
import 'package:provider/provider.dart';

class SubmitComplaint extends StatefulWidget {
  @override
  _SubmitComplaintState createState() => _SubmitComplaintState();
}

class _SubmitComplaintState extends State<SubmitComplaint> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController feedback = new TextEditingController();

  bool isLoading = false;

  _submitComplaint() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      ClientHelper.submitComplaint(
              Provider.of<UserProvider>(context, listen: false)
                  .getUserInf()
                  .getId(),
              feedback.text)
          .then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientMainPage(
                    "open",
                    "Activity Page",
                    "If you have any problems.We will be happy to help",
                    "assets/images/problem_icon.png",
                    true)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(82, 82, 82, 1),
      ),
      drawer: ClientDrawer(),
      body: SafeArea(
        child: isLoading
            ? LoadingProgress()
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/log_back.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 50,
                            color: Color.fromRGBO(57, 57, 57, 1),
                            child: Center(
                                child: Text(
                              "Complaint",
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
                          Center(
                              child: Text(
                            "Hello Dear user, \n Send your complaint \n and we will solve it soon.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.asar(
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                              fontSize: 15,
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                          padding: EdgeInsets.all(30),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 60,
                                ),
                                Container(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            controller: feedback,
                                            textInputAction:
                                                TextInputAction.next,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            maxLines: 4,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Please write the complaints",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'please write the email';
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
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromRGBO(52, 52, 52, 1)),
                                  child: Center(
                                    child: FlatButton(
                                        child: Text(
                                          "Submit Complaint",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          // when we press this button excute login function

                                          _submitComplaint();
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
