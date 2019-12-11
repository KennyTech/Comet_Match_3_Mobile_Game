/*
* Main Game Menu
*
* Initial menu screen including buttons for [Play], [Settings], [Quit], etc.
*
*/
import 'package:flutter/material.dart';

import 'package:finalproject/screen/level_select.dart';
import 'package:finalproject/screen/character_compendium.dart';
import 'package:finalproject/screen/settings_screen.dart';
import 'package:finalproject/screen/test_console.dart';
import 'package:finalproject/screen/credits_screen.dart';
import 'package:finalproject/screen/scores_chart_screen.dart';

import 'package:finalproject/services/base_auth.dart';

import 'package:flutter_i18n/flutter_i18n.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key key, this.auth, this.userId, this.logoutCallback}) : super(key: key);

  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() {
    return MainMenuState();
  }
}

class MainMenuState extends State<MainMenu> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Game Base"),
        actions: <Widget>[
          PopupMenuButton<String>(
            offset: Offset(0, 100),
            onSelected: (choice) {
              if(choice == 'Logout') {
                showLogOutAlertDialog(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Logout',
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text('Logout'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
              )
            ]
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Mobile Project Game Base",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 18)),
                ],
              ),
            ),

            // Buttons
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    splashColor: Colors.white,
                    onPressed: () => _goToScreen("level_select"),
                    child: Text(FlutterI18n.translate(context, 'menu.play'), textScaleFactor: 1.5, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    splashColor: Colors.white,
                    onPressed: () => _goToScreen("character"),
                    child: Text(FlutterI18n.translate(context, 'menu.characters'), textScaleFactor: 1.5, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    splashColor: Colors.white,
                    onPressed: () => _goToScreen("scores"),
                    child: Text(FlutterI18n.translate(context, 'menu.scores'), textScaleFactor: 1.5, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    splashColor: Colors.white,
                    onPressed: () => _goToScreen("settings"),
                    child: Text(FlutterI18n.translate(context, 'menu.settings'), textScaleFactor: 1.5, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    splashColor: Colors.white,
                    onPressed: () => _goToScreen("credits"),
                    child: Text(FlutterI18n.translate(context, 'menu.credits'), textScaleFactor: 1.5, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    splashColor: Colors.white,
                    onPressed: () => _goToScreen("test_console"),
                    child: Text(FlutterI18n.translate(context, 'menu.testconsole'), textScaleFactor: 1.5, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    splashColor: Colors.white,
                    onPressed: () => {},
                    child: Text(FlutterI18n.translate(context, 'menu.quit'), textScaleFactor: 1.5, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToScreen(String screen) async {
    debugPrint("Going to play screen");

    bool result =
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (screen == "level_select") return LevelSelect(0);
      else if (screen == "character") return CharacterCompendium(0);
      else if (screen == "scores") return ScoresChartScreen();
      else if (screen == "settings") return SettingsScreen(0);
      else if (screen == "credits") return CreditsScreen(0);
      else if (screen == "test_console") return TestConsole(0);
      // default return if no match
      return LevelSelect(0);
    }));

    if (result == true) {
      // do something if needed in future
    }
  }

  //dialog to log out
  showLogOutAlertDialog(BuildContext context) {
    // set up the buttons
    Widget noBtn = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesBtn = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        await widget.auth.signOut();

        widget.logoutCallback();

        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout?"),
      actions: [
        noBtn,
        yesBtn,
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
