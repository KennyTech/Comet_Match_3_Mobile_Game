/*
* Main Game Menu
*
* Initial menu screen including buttons for [Play], [Settings], [Quit], etc.
*
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:finalproject/screen/level_select.dart';
import 'package:finalproject/screen/settings_screen.dart';
import 'package:finalproject/screen/test_console.dart';
import 'package:finalproject/screen/credits_screen.dart';
import 'package:finalproject/screen/scores_chart_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:nice_button/nice_button.dart';
import 'package:finalproject/services/base_auth.dart';

class MenuItem {
  final String name;
  final Color color;
  final double x;

  MenuItem({this.name, this.color, this.x});
}

class MainMenu extends StatefulWidget {
  MainMenu({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() {
    return MainMenuState();
  }
}

class MainMenuState extends State<MainMenu> {
  List items = [
    MenuItem(
      x: -1.0,
      name: 'comet',
      color: Colors.yellow,
    ),
    MenuItem(
      x: -0.5,
      name: 'leaderboard',
      color: Colors.purple,
    ),
    MenuItem(
      x: 0.0,
      name: 'testconsole',
      color: Colors.grey,
    ),
    MenuItem(
      x: 0.5,
      name: 'setting',
      color: Colors.pink,
    ),
    MenuItem(
      x: 1.0,
      name: 'planet2',
      color: Colors.purple,
    )
  ];

  MenuItem active;

  AudioPlayer advancedPlayer;

  @override
  void initState() {
    super.initState();
    active = items[0];
    loadMusic();
  }

  Future loadMusic() async {
    advancedPlayer = await AudioCache().loop("../assets/audios/mainmenu3.mp3");
  }

  pause() async {
    await advancedPlayer.pause();
  }

  play() async {
    await advancedPlayer.play("../assets/audios/mainmenu3.mp3");
  }

  @override
  void dispose() {
    advancedPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var firstColor = Color(0xFFD500F9), secondColor = Color(0xFF6A1B9A);
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Container(
        //color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 900.00,
                height: 300.00,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: ExactAssetImage('assets/images/logo.png'),
                    fit: BoxFit.fitHeight,
                  ),
                )),
            Container(
              height: 77,
              width: 390,
              //color: Colors.,
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    alignment: Alignment(active.x, -1),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      height: 8,
                      width: w * 0.2,
                      color: active.color,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: items.map((item) {
                        return _flare(item);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 77,
              width: 390,
              //color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "play",
                    style: TextStyle(color: Colors.yellow, fontSize: 13.0),
                  ),
                  Text(
                    "    highscores",
                    style: TextStyle(color: Colors.pink, fontSize: 13.0),
                  ),
                  Text(
                    "testconsole ",
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  ),
                   Text(
                    "settings",
                    style: TextStyle(color: Colors.red, fontSize: 13.0),
                  ),
                  Text(
                    " credits",
                    style: TextStyle(color: Colors.purple, fontSize: 13.0),
                  ),
                ],
              ),
            ),
            Container(
              height: 77,
              width: 390,
              // color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: new Icon(
                      Icons.music_note,
                      color: Colors.purple[300],
                      size: 34.0,
                    ),
                    onPressed: () {
                      loadMusic();
                    },
                  ),
                  IconButton(
                    icon: new Icon(
                      Icons.pause,
                      color: Colors.teal[300],
                      size: 34.0,
                    ),
                    onPressed: () {
                      pause();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: NiceButton(
                      radius: 40,
                      width: 145,
                      elevation: 8.0,
                      padding: const EdgeInsets.all(15),
                      text: "Quit",
                      fontSize: 16.0,
                      icon: Icons.home,
                      gradientColors: [secondColor, firstColor],
                      onPressed: () {
                        //quit
                      },
                      background: null,
                    ),
                  ),
                  NiceButton(
                    radius: 40,
                    width: 145,
                    elevation: 8.0,
                    padding: const EdgeInsets.all(15),
                    text: "Logout",
                    fontSize: 16.0,
                    icon: Icons.exit_to_app,
                    gradientColors: [secondColor, firstColor],
                    onPressed: () {
                      showLogOutAlertDialog(context);
                    },
                    background: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Icon Animation
  // ---------------------------------------
  Widget _flare(MenuItem item) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: FlareActor(
            'assets/${item.name}.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: item.name == active.name ? 'go' : 'idle',
          ),
        ),
      ),
      onTap: () {
        setState(() {
          active = item;
        });
      },
      onDoubleTap: () {
        _goToScreen(item);
      },
    );
  }

  // Screen Navigation
  // ---------------------------------------
  void _goToScreen(MenuItem item) async {
    debugPrint("Going to play screen");

    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (item.name == 'comet')
        return LevelSelect(0);
      else if (item.name == 'leaderboard')
        return ScoresChartScreen();
      else if (item.name == 'testconsole')
        return TestConsole(0);
      else if (item.name == 'setting')
        return SettingsScreen(0);
      else if (item.name == 'planet2') return CreditsScreen(0);
      // default return if no match
      return LevelSelect(0);
    }));

    if (result == true) {
      // do something if needed in future
    }
  }

  // Logout functions
  // ---------------------------------------

  //dialog to log out
  showLogOutAlertDialog(BuildContext context) {
    // set up the buttons
    Widget noBtn = FlatButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.teal[400]),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesBtn = FlatButton(
      child: Text(
        "Yes",
        style: TextStyle(color: Colors.teal[400]),
      ),
      onPressed: () async {
        await widget.auth.signOut();

        widget.logoutCallback();

        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Logout",
        style: TextStyle(color: Colors.teal[400]),
      ),
      content: Text(
        "Are you sure you want to logout?",
        style: TextStyle(color: Colors.teal[400]),
      ),
      backgroundColor: Color(0xFF1F1B24),
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
