/*
* Credits Screen
*
* Screen showing credits.
*/

import 'dart:async';
import 'package:flutter/material.dart';

class CreditsScreen extends StatefulWidget {
  final int state; // use if needed otherwise remove as argument

  CreditsScreen(this.state);

  @override
  State<StatefulWidget> createState() {
    return CreditsScreenState(this.state);
  }
}

class CreditsScreenState extends State<CreditsScreen> {
  int state;
  CreditsScreenState(this.state);

  // Author Database
  // ---------------------------------
  List<String> _authorNames = [
    "Mustafa Al-Azzawe",
    "Daniyal Shah",
    "Kenny Le",
    "Alvin Lum",
  ]; 

  List<String> _roles = [
    "Programmer, UI, Art, Design",
    "Programmer, UI, Art, Design",
    "Programmer, UI, Art, Design",
    "Programmer, UI, Art, Design",
  ];

  /*
  List<String> _authorImage = [
    // TO-DO  
  ]
  */

  // ---------------------------------

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          goToPreviousScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Credits"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  goToPreviousScreen();
                }),
          ),
          body: getCredits(),
        ));
  }

  ListView getCredits() {
    return ListView.builder(
      itemCount: 4, // number of authors
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(getFirstTwoLetters(this._authorNames[position]),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            
            title: Text(this._authorNames[position],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)), // Names
         
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(this._roles[position] + "\n", style: TextStyle(color: Colors.grey)), // Roles
              ],
            ),
            
            onTap: () {
              //
            },
          ),
        );
      },
    );
  }

  getFirstTwoLetters(String title) {
    return title.substring(0, 2);
  }

  void goToPreviousScreen() {
    Navigator.pop(context, true);
  }
}
