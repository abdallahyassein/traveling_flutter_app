import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/helper/AdminHelper.dart';
import 'package:mechanicscarfix/helper/MixHelper.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';
import 'package:mechanicscarfix/widgets/admin_drawer.dart';
import 'package:mechanicscarfix/widgets/loading_progress.dart';
import 'package:provider/provider.dart';

class AllAdminsPage extends StatefulWidget {
  final String type;
  final String title;
  final String emptymessage;
  final String tileimage;

  AllAdminsPage(
    this.type,
    this.title,
    this.emptymessage,
    this.tileimage,
  );
  @override
  _AllAdminsPageState createState() => _AllAdminsPageState();
}

class _AllAdminsPageState extends State<AllAdminsPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context, listen: false).getUserInf();
    final users = MixHelper.getAllUsers(widget.type);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(82, 82, 82, 1),
      ),
      drawer: AdminDrawer(),
      body: Container(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Color.fromRGBO(57, 57, 57, 1),
                    child: Center(
                        child: Text(
                      widget.title,
                      style: GoogleFonts.aclonica(
                        textStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        fontSize: 35,
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(82, 82, 82, 0.6),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: FutureBuilder(
                        future: users,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingProgress();
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              (!snapshot.hasData ||
                                  snapshot.data.length == 0)) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                  child: Text(widget.emptymessage,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.antic(
                                        textStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                103, 147, 203, 1),
                                            fontSize: 35),
                                      ))),
                            );
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                // ignore: missing_return
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    elevation: 2,
                                    child: ListTile(
                                        leading: Image.asset(widget.tileimage),
                                        title: Column(
                                          children: [
                                            Text(
                                              snapshot.data[index].name,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data[index].address,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          snapshot.data[index].phone,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                            size: 25,
                                          ),
                                          onPressed: () {
                                            AdminHelper.deleteAdmin(
                                                    snapshot.data[index].id)
                                                .then((value) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllAdminsPage(
                                                              widget.type,
                                                              widget.title,
                                                              widget
                                                                  .emptymessage,
                                                              widget
                                                                  .tileimage)));
                                            });
                                          },
                                        )),
                                  );
                                });
                          }
                        })),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
