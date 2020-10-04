/* login page */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';

import 'package:mechanicscarfix/widgets/loading_progress.dart';

import 'package:mechanicscarfix/helper/AdminHelper.dart';
import 'package:mechanicscarfix/models/User.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // the key for the form
  TextEditingController email =
      new TextEditingController(); // the controller for the usename that user will put in the text field
  TextEditingController pass =
      new TextEditingController(); // the controller for the password that user will put in the text field

  bool isLoading = false;

  _login() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Provider.of<UserProvider>(context, listen: false)
          .loginUser(email.text, pass.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: isLoading
              ? LoadingProgress()
              : Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topCenter, colors: [
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
                              "Login",
                              style: TextStyle(
                                  fontSize: 45,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                              "Hello Dear user, \n Welcome to our App.We hope \n to solve your problem.",
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
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
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
                                              controller: email,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onEditingComplete: () =>
                                                  FocusScope.of(context)
                                                      .nextFocus(),
                                              decoration: InputDecoration(
                                                  hintText: "Email",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none),
                                              keyboardType: TextInputType.text,
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
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              controller: pass,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onEditingComplete: () =>
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none),
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                            ),
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color.fromRGBO(91, 142, 207, 1)),
                                    child: Center(
                                      child: FlatButton(
                                          child: Text(
                                            "Sign in",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            // when we press this button excute login function
                                            AdminHelper.registerUser(User(
                                                "0",
                                                "asd",
                                                "123456789",
                                                "5",
                                                "asd",
                                                "asd@yahoo.com",
                                                "123456789",
                                                "client"));
                                            _login();
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
      ),
    );
  }
}
