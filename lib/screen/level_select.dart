/*
* Level Select Screen
*
* The screen to select level prior to game start.
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:finalproject/screen/play_screen.dart';

class LevelSelect extends StatefulWidget {
  final int state; // use if needed otherwise remove as argument

  LevelSelect(this.state);

  @override
  State<StatefulWidget> createState() {
    return LevelSelectState(this.state);
  }
}

class LevelSelectState extends State<LevelSelect> {
  int state;
  LevelSelectState(this.state);

  int count = 0; // levels
  int _selectedLevel = 0; // selected level
  List<bool> _selectedLevelColor = [
    false,
    false,
    false,
    false,
    false
  ]; // one for each level

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          goToPreviousScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Level Select"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  goToPreviousScreen();
                }),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Select Level',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // 5 levels
                    itemBuilder: (BuildContext context, int index) => Card(
                      color: _selectedLevelColor[index]
                        ? Colors.blue[100]
                        : Colors.white,
                      child: InkWell(
                        onTap: () {
                          debugPrint('Selected a grade');
                          _selectedLevel = index; // Set as selected
                          setState(() {
                            _removePrevColor(); // remove previous selection highlight
                            _selectedLevelColor[_selectedLevel] =
                              !_selectedLevelColor[_selectedLevel]; // highlight new selection
                          });
                        },
                        child: Text("      Level $index      ")),
                    )),
                ),
                Text(
                  'Level Information',
                  style: TextStyle(fontSize: 18),
                ),
                Card(
                  child: ListTile(
                      title: Text('Summary: '),
                      subtitle: Text(
                          'Summary of selected level / difficulty / stuff')), // TO-DO: Update information based on selected level
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Back',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          goToPreviousScreen();
                          setState(() {
                            debugPrint("Back clicked");
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Start',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          _goToPlayScreen(1); // _goToPlayScreen(int level)
                          setState(() {
                            debugPrint("Start clicked");
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void goToPreviousScreen() {
    Navigator.pop(context, true);
  }

  // Remove color highlight from previous selected level
  void _removePrevColor() {
    for (int i = 0; i < 5; i++) {
      // 5 levels
      _selectedLevelColor[i] =
          false; // set all previous color highlight to false
    }
  }

  void _goToPlayScreen(int level) async {
    debugPrint("Going to play screen");

    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlayScreen(level);
    }));

    if (result == true) {
      // do something if needed in future
    }
  }
}
