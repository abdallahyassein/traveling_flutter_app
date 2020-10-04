/* login page */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';

import 'package:mechanicscarfix/widgets/loading_progress.dart';

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
    return new Scaffold(
        body: new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/log_back.jpg"), fit: BoxFit.cover),
      ),
      child: isLoading
          ? LoadingProgress()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Travelcations",
                      style: GoogleFonts.aclonica(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        child: Stack(
                      alignment: Alignment.topCenter,
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.29,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(25.0),
                                            child: TextFormField(
                                                controller: email,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onEditingComplete: () =>
                                                    FocusScope.of(context)
                                                        .nextFocus(),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'please write the email';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  icon: Icon(
                                                    Icons.mail_outline,
                                                    color: Colors.black,
                                                    size: 30.0,
                                                  ),
                                                  hintText: "Enter an Email",
                                                  hintStyle: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.3,
                                                      color: Colors.black87),
                                                )),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            height: 1.0,
                                            color: Colors.grey[700],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: pass,
                                              textInputAction:
                                                  TextInputAction.done,
                                              onEditingComplete: () =>
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                icon: Icon(
                                                  Icons.lock_outline,
                                                  size: 30.0,
                                                  color: Colors.black,
                                                ),
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.3,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.29,
                          child: Container(
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                boxShadow: [
                                  new BoxShadow(
                                    color: const Color(0xffff006a),
                                    offset: new Offset(1.0, 1.0),
                                    blurRadius: 10.0,
                                  ),
                                  new BoxShadow(
                                    color: const Color(0xfff59648),
                                    offset: new Offset(-1.0, -1.0),
                                    blurRadius: 10.0,
                                  )
                                ],
                              ),
                              child: MaterialButton(
                                highlightColor: Colors.transparent,
                                splashColor: const Color(0xffe00d62),
                                onPressed: () {},
                                child: InkWell(
                                  onTap: _login,
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 60.0, vertical: 13.0),
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            fontSize: 27.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.3),
                                      )),
                                ),
                              )),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
    ));
  }
}
