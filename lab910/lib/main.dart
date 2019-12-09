import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lab910/map.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 9 and 10',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MapsPage(title: 'Lab 9 and 10'),
    );
  }
}

// class MapsPage extends StatefulWidget {
//   MapsPage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MapsPageState createState() => _MapsPageState();
// }

// class _MapsPageState extends State<MapsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ShowMap(),
//     );
//   }

