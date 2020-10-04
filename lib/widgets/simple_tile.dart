import 'package:flutter/material.dart';

class SimpleTile extends StatelessWidget {
  
  final String listTitle;
  final String image;
  final Function function;

  SimpleTile(this.listTitle,this.image,this.function);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:   ListTile(
            title: Text(
              listTitle,
              style: TextStyle(color: Colors.indigo, fontSize: 17),
            ),
            leading: Image.asset(
              image,
              height: 75,
              width: 75,
            ),
            onTap: function
          ),
         

    );
  }
}