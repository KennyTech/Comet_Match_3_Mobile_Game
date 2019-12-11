/*
* Play Screen
*
* The screen where the gameplay takes place.
*/

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class PlayScreen extends StatefulWidget {

  //PlayScreen({Key key}) : super(key: key);

  final int level;

  PlayScreen(this.level);
  
  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen>{

  int playerScore = 0;

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController _unityWidgetController;

  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: WillPopScope(
          onWillPop: () {
            // Pop the category page if Android back button is pressed.
          },
          child: Container(
            color: Colors.yellow,
            child: UnityWidget(
              onUnityViewCreated: onUnityCreated,
              isARScene: false,
              onUnityMessage: onUnityMessage,
            ),
          ),
        ),
      ),
    );
  }

  // Communication from Flutter to Unity to tell Unity which level to load
  // void setLevel(int level) {
  //   _unityWidgetController.postMessage(
  //     'LevelManager',
  //     'setLevel',
  //     level,
  //   );
  // }

  // Receive score from Unity
  void onUnityMessage(controller, message) {
    print('Received message from unity: ${message.toString()}');
    playerScore = int.parse(message.toString());
    print("Player Score: " + playerScore.toString()); // Test
    _unityWidgetController.pause();
    //goToPreviousScreen();
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }

  void goToPreviousScreen() {
		Navigator.pop(context, true);
  }

}