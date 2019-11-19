/*
* Character Compendium Screen
*
* This screen is a gridview of characters, each can be tapped to open a full screen with more character information.
* TO-DO: Gridview, open full screen
*/

import 'dart:async';
import 'package:flutter/material.dart';

class CharacterCompendium extends StatefulWidget {
  final int state; // use if needed otherwise remove as argument

  CharacterCompendium(this.state);

  @override
  State<StatefulWidget> createState() {
    return CharacterCompendiumState(this.state);
  }
}

class CharacterCompendiumState extends State<CharacterCompendium> {
  int state;
  CharacterCompendiumState(this.state);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          goToPreviousScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Character Compendium"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  goToPreviousScreen();
                }),
          ),


          body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(30, (index) {
            return Center(
              child: Text(
                'Character $index',
                style: Theme.of(context).textTheme.headline,
              ),
            );
          }),
        ),


      ),
    );
  }



  void goToPreviousScreen() {
    Navigator.pop(context, true);
  }
}
