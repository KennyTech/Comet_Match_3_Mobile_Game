/*
* Play Screen
*
* The screen where the gameplay takes place.
*/

import 'dart:async';
import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {

	final int level; // use if needed otherwise remove as argument

	PlayScreen(this.level);

	@override
  State<StatefulWidget> createState() {

    return PlayScreenState(this.level);
  }
}

class PlayScreenState extends State<PlayScreen> {

	int level;
	PlayScreenState(this.level);

	@override
  Widget build(BuildContext context) {

    return WillPopScope(

	    onWillPop: () {
		    goToPreviousScreen();
	    },

	    child: Scaffold(
	    appBar: AppBar(
		    title: Text("Play Game"),
		    leading: IconButton(icon: Icon(
				    Icons.arrow_back),
				    onPressed: () {
		    	    goToPreviousScreen();
				    }
		    ),
	    ),

	    body: Padding(
		    padding: EdgeInsets.all(5.0),
		    child: ListView(
			    children: <Widget>[

            // Add widgets

			    ],
		    ),
	    ),

    ));
  }

  void goToPreviousScreen() {
		Navigator.pop(context, true);
  }

}