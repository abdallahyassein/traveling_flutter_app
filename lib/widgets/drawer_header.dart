import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanicscarfix/provider/UserProvider.dart';
import 'package:provider/provider.dart';

class DrawerHead extends StatelessWidget {
  final String image;

  DrawerHead(this.image);

  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context, listen: false).getUserInf();

    return Container(
      child: DrawerHeader(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  image,
                  height: 75,
                  width: 75,
                ),
                Text(
                  userProvider.getName(),
                  style: GoogleFonts.antic(
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    fontSize: 17,
                  ),
                ),
                Text(
                  userProvider.getAddress(),
                  style: GoogleFonts.antic(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    fontSize: 13,
                  ),
                ),
                Text(
                  userProvider.getPhone(),
                  style: GoogleFonts.antic(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(59, 59, 59, 1),
        ),
      ),
    );
  }
}
