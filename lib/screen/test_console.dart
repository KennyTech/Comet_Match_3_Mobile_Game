/*
* Test Console Screen
*
* Test buttons to allow quick and easy testing of all app features.
*/

import 'dart:async';
import 'package:flutter/material.dart';

class TestConsole extends StatefulWidget {
  final int state; // use if needed otherwise remove as argument

  TestConsole(this.state);

  @override
  State<StatefulWidget> createState() {
    return TestConsoleState(this.state);
  }
}

class TestConsoleState extends State<TestConsole> {
  int state;
  TestConsoleState(this.state);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          goToPreviousScreen();
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Test Console"),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    goToPreviousScreen();
                  }),
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
                            Text("Test Console",
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
                              onPressed: () => {},
                              child: Text('Gain Max Currency',
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
                              child: Text('Unlock All Levels',
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
                              child: Text('Set High Score',
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
                              child: Text('Notify Me in 10 Seconds',
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
                              child: Text('Back',
                                  textScaleFactor: 1.5,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ]))));
  }

  void goToPreviousScreen() {
    Navigator.pop(context, true);
  }
}
