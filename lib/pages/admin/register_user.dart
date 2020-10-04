/* login page */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/AdminHelper.dart';
import 'package:mechanicscarfix/models/User.dart';
import 'package:mechanicscarfix/pages/admin/admin_main.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();

  int selectedRadio = 1;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    User user;

    Future<void> _showMyDialog(title, message) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  if (title == "Success") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminMainPage(
                                "open",
                                "Main Admin Page",
                                "There is no problems right now",
                                "assets/images/add_user.png",
                                false)));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterUser()));
                  }
                },
              ),
            ],
          );
        },
      );
    }

    _submitUser() {
      if (_formKey.currentState.validate()) {
        String status = "client";

        if (selectedRadio == 1) {
          status = "client";
        } else if (selectedRadio == 2) {
          status = "driver";
        } else if (selectedRadio == 3) {
          status = "admin";
        }

        setState(() {
          _isLoading = true;
        });

        user = new User("0", name.text, phone.text, "", address.text,
            email.text, password.text, status);

        AdminHelper.registerUser(user).then((value) {
          if (value == true) {
            _showMyDialog("Success", "The Account Created Successfully");
          } else {
            _showMyDialog("Alert", "The Email is used before");
          }
        });
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            "Add User",
                            style: GoogleFonts.aclonica(
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
                                  height: 10,
                                ),
                                Container(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
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
                                            controller: name,
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                                hintText: "Full Name",
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
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            controller: email,
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                                hintText: "Email",
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
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            controller: password,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            obscureText: true,
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'please fill the data';
                                              }
                                              if (value.length < 6) {
                                                return 'your password is less than 6 characters';
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
                                            controller: confirmPassword,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            obscureText: true,
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                                hintText: "Confirm Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'please fill the data';
                                              }
                                              if (value != password.text) {
                                                return 'Password does not match';
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
                                            controller: address,
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                                hintText: "Address",
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
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            controller: phone,
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .unfocus(),
                                            decoration: InputDecoration(
                                                hintText: "Phone Number",
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
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Colors.green,
                                      groupValue: selectedRadio,
                                      value: 1,
                                      onChanged: (val) {
                                        setSelectedRadio(val);
                                      },
                                    ),
                                    Text('Client',
                                        style: GoogleFonts.asar(
                                          textStyle: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold),
                                          fontSize: 20,
                                        )),
                                    Radio(
                                      activeColor: Colors.green,
                                      groupValue: selectedRadio,
                                      value: 2,
                                      onChanged: (val) {
                                        setSelectedRadio(val);
                                      },
                                    ),
                                    Text('Driver',
                                        style: GoogleFonts.asar(
                                          textStyle: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold),
                                          fontSize: 20,
                                        )),
                                    Radio(
                                      activeColor: Colors.green,
                                      groupValue: selectedRadio,
                                      value: 3,
                                      onChanged: (val) {
                                        setSelectedRadio(val);
                                      },
                                    ),
                                    Text('Admin',
                                        style: GoogleFonts.asar(
                                          textStyle: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold),
                                          fontSize: 20,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
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
                                          "Submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          _submitUser();
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
