/*
* Program: Forms and SQLite 
* Author: Kenny Le - 100616323
* Purpose: Grade entry system with SQLite for CSCI 4100U Lab 05/06
* Submitted on: 2019/11/12
* Submitted to: Jude Arokiam / Randy Fortier
*/

import 'package:flutter/material.dart';
import 'package:sqlite/screen/main_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Project Game',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MainMenu(), // Show the first screen
    );
  }
}