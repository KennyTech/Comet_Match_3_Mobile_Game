/*
* Settings Screen
*
* Change particular settings (ie. notification settings, volume slider, etc)
*/

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  double _sliderValue = 10.0; // Volume slider

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        goToPreviousScreen();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF121212),
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Settings"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: 120.0,
                    alignment: Alignment.center,
                    child: Text('Volume ',
                    style: TextStyle(color: Colors.teal[300], fontSize: 18),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Slider(
                      // volume slider
                      activeColor: Colors.purple,
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
                    child: Text(
                      '${_sliderValue.toInt()}',
                      style: TextStyle(color: Colors.teal[300], fontSize: 18), // volume slider number display
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: RaisedButton(
                      color: Colors.purple[300],
                      textColor: Colors.white,
                      child: Text(
                        'EN',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Locale newLocale = Locale('en');
                        setState(() {
                          FlutterI18n.refresh(context, newLocale);
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: RaisedButton(
                      color: Colors.purple[300],
                      textColor: Colors.white,
                      child: Text(
                        'PT',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Locale newLocale = Locale('pt');
                        setState(() {
                          FlutterI18n.refresh(context, newLocale);
                        });
                      },
                    ),
                  ),
                ],
              ),
              RaisedButton(
                color: Colors.purple[300],
                child: Text(FlutterI18n.translate(context, 'menu.save'),
                    textScaleFactor: 1.5,
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showAlertDialog(context);
                },
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

  //dialog to save changes
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(color: Colors.teal[400]),),

      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue", style: TextStyle(color: Colors.teal[400]),),
      textColor: Colors.white,
      onPressed: () {
        goToPreviousScreen();

        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Settings Saved!'),
          duration: Duration(seconds: 2),
        ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Save Changes", style: TextStyle(color: Colors.teal[400]),),
      content: Text("Would you like to save changes?", style: TextStyle(color: Colors.teal[400]),),
      backgroundColor: Color(0xFF1F1B24),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
