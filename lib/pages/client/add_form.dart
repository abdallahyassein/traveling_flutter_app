/* login page */

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/ClientHelper.dart';
import 'package:mechanicscarfix/models/RequestForm.dart';
import 'package:mechanicscarfix/pages/client/client_main.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';
import 'package:provider/provider.dart';

import 'package:geolocator/geolocator.dart';

class AddIssueForm extends StatefulWidget {
  @override
  _AddIssueFormState createState() => _AddIssueFormState();
}

class _AddIssueFormState extends State<AddIssueForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController address = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController type = new TextEditingController();
  TextEditingController details = new TextEditingController();
  bool isLoading = false;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUserInf();
    address.text =
        _currentAddress == null ? user.getAddress() : _currentAddress;
    phone.text = user.getPhone();

    _addIssueForm() {
      if (_formKey.currentState.validate()) {
        setState(() {
          isLoading = true;
        });

        RequestForm issueForm = RequestForm(
            clientId: user.getId(),
            address: address.text,
            phoneNumber: phone.text,
            carType: type.text,
            details: details.text,
            createdAt: DateTime.now().toString(),
            driverId: "",
            rate: "",
            userRate: "",
            price: "",
            finishedAt: "",
            timeDriverAccepted: "",
            paymentMethod: "Cash",
            status: "open");

        ClientHelper.addIssueForm(issueForm).then((value) => Navigator.push(
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
                            "Form",
                            style: GoogleFonts.antic(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              fontSize: 45,
                            ),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Text(
                            "Please fill in the information so we can help you .",
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
                            color: Color.fromRGBO(82, 82, 82, 0.8),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
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
                                              controller: address,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textInputAction:
                                                  TextInputAction.next,
                                              onEditingComplete: () =>
                                                  FocusScope.of(context)
                                                      .nextFocus(),
                                              decoration: InputDecoration(
                                                  hintText: "Address",
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                  border: InputBorder.none),
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'please fill the data';
                                                } else {
                                                  return null;
                                                }
                                              },
                                            )),
                                        FlatButton(
                                          child: Text("current location",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            _getCurrentLocation();
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.white))),
                                          child: TextFormField(
                                            controller: phone,
                                            style:
                                                TextStyle(color: Colors.white),
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                                hintText: "Phone Number",
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
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
                                                      color: Colors.white))),
                                          child: TextFormField(
                                            controller: type,
                                            style:
                                                TextStyle(color: Colors.white),
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .nextFocus(),
                                            decoration: InputDecoration(
                                                hintText: "Car Type",
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
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
                                                      color: Colors.white))),
                                          child: TextFormField(
                                            controller: details,
                                            style:
                                                TextStyle(color: Colors.white),
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                FocusScope.of(context)
                                                    .unfocus(),
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Details about your trip",
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
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
                                          // when we press this button excute login function

                                          _addIssueForm();
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

  _getCurrentLocation() {
    print('Working');
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      print('Working');
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality},${place.subAdministrativeArea},${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
