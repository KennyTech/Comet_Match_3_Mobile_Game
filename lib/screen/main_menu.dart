/*
* Main Game Menu
*
* Initial menu screen including buttons for [Play], [Settings], [Quit], etc.
*
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqlite/screen/level_select.dart';
import 'package:sqlite/screen/character_compendium.dart';
import 'package:sqlite/screen/settings_screen.dart';
import 'package:sqlite/screen/test_console.dart';
import 'package:sqlite/screen/credits_screen.dart';
import 'package:sqlite/screen/scores_chart_screen.dart';

class MainMenu extends StatefulWidget {
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
                    child: Text('Play',
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white)),
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
                    child: Text('Characters',
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white)),
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
                    child: Text('Scores',
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white)),
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
                    child: Text('Settings',
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white)),
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
                    child: Text('Credits',
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white)),
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
                    child: Text('Test Console',
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white)),
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
                    child: Text('Quit',
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white)),
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

  // Alert (currently unused)
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
