/*
* Settings Screen
*
* Change particular settings (ie. notification settings, volume slider, etc)
*/

import 'dart:async';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final int state; // use if needed otherwise remove as argument

  SettingsScreen(this.state);

  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState(this.state);
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  int state;
  SettingsScreenState(this.state);

  double _sliderValue = 10.0; // Volume slider

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        goToPreviousScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                goToPreviousScreen();
              }),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 120.0,
                alignment: Alignment.center,
                child: Text('Volume ', // volume slider number display
                    style: Theme.of(context).textTheme.display1),
              ),
              Flexible(
                flex: 1,
                child: Slider( // volume slider
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 100.0,
                  onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                  },
                  value: _sliderValue,
                ),
              ),
              Container(
                width: 70.0,
                alignment: Alignment.center,
                child: Text('${_sliderValue.toInt()}', // volume slider number display
                    style: Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToPreviousScreen() {
    Navigator.pop(context, true);
  }
}
