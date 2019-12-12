/*
* Scores Table Screen
*
* This screen displays scores as tables
*/

import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/rendering.dart';
import 'package:finalproject/screen/scores_chart_screen.dart';
import 'package:finalproject/localstorage/players_model.dart';
import 'package:finalproject/localstorage/player.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

import 'package:finalproject/screen/main_menu.dart';

class ScoresTableScreen extends StatefulWidget {

	ScoresTableScreen();

	@override
  State<StatefulWidget> createState() {

    return ScoresTableScreenState();
  }
}

class Level {
  final String level;
  final int times;
  final charts.Color color;

  Level(this.level, this.times, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class RecentScore {
  final String number;
  final int score;
  final charts.Color color;

  RecentScore(this.number, this.score, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class ScoresTableScreenState extends State<ScoresTableScreen> {

  PlayersModel databaseHelper = PlayersModel();
  List<Player> playerList;
  int playerCount = 0;
  int currentPlayer = 0;
  String tempPlayerName1 = "null";
  String tempPlayerScore1 = "0";
  String tempPlayerName2 = "null";
  String tempPlayerScore2 = "0";
  String tempPlayerName3 = "null";
  String tempPlayerScore3 = "0";
  static String tempName;
  static String tempScore;
  static String tempDate;

   Stream<int> timedCounter(Duration interval, [int maxCount]) async* {
    int i = 0;
    while (true) {
      await Future.delayed(interval);
      yield i++;

      setState(() {
        var rng = new Random();
        
        if(rng.nextInt(1) == 0) {
          tempPlayerName1 = "Bob";
          tempPlayerName2 = "Bill";
          tempPlayerName3 = "Billy";
        } else {
          tempPlayerName1 = "John";
          tempPlayerName2 = "Joe";
          tempPlayerName3 = "Jospeh";
        }
    
        tempPlayerScore1 = rng.nextInt(100).toString();
        tempPlayerScore2 = rng.nextInt(100).toString();
        tempPlayerScore3 = rng.nextInt(100).toString();

      });

  
      if (i == maxCount) break;
    }
   }

  @override
  Widget build(BuildContext context) {
    
    double scrWidth = MediaQuery.of(context).size.width;

    // _updateTestPlayers(); // to test

    // if (playerList == null) {
    //   debugPrint('null player list');
    //   playerList = List<Player>();
    //   updateTableView();
    // }
    

    return Scaffold(
      appBar: AppBar(
          leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()))
        ), 
        title: Text("High Scores"), 
      ),
      body: SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

             Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 2.5),
                      width: scrWidth/2 - 10,
                      height: 60,
                      child: RaisedButton(
                        elevation: 5,
                        color: Colors.teal[400],
                        textColor: Colors.white,
                        child: Text(
                          'Score Charts',
                          textScaleFactor: 1.4,
                        ),
                        onPressed: () => _goToChartScreen(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5, left: 2.5, right: 5),
                      width: scrWidth/2 - 10,
                      height: 60,
                      child: RaisedButton(
                        elevation: 5,
                        color: Colors.purple[400],
                        textColor: Colors.white,
                        child: Text(
                          'High Score Table',
                          textScaleFactor: 1.4,
                        ),
                        onPressed: () {
                          //TODO: Implement High Scores Table 

                        },
                      ),
                    ),
                  ],
            ),

            StreamBuilder<int>(
              stream: timedCounter(Duration(seconds: 1), 1),
              //print an integer every 2secs, 10 times
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                }
                int count = snapshot.data;
              return DataTable(
            rows: [
              DataRow(
                cells: [
                  DataCell(Text("Mustafa")),
                  DataCell(Text("95")),
                  DataCell(Text("2019-11-29")),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text("Daniyal")),
                  DataCell(Text("90")),
                  DataCell(Text("2019-11-30")),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text("Kenny")),
                  DataCell(Text("85")),
                  DataCell(Text("2019-12-01")),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text("Alvin")),
                  DataCell(Text("80")),
                  DataCell(Text("2019-12-02")),
                ],
              ),
            ],
            columns: [
              DataColumn(
                label: Text("Player"),
              ),
              DataColumn(
                label: Text("High Score"),
              ),
              DataColumn(
                label: Text("Date"),
              ),
            ]);
            },
            ),
          ],
        ),
      ),
    );
  }

  // void _updateTestPlayers() {
    
  //   debugPrint('updating test players to table view');

  //   if (playerList[0].name != null)
  //     tempPlayerName = playerList[0].name;
  //   else 
  //     tempPlayerName = "null";

  //   if (playerList[1].highscore != null)
  //     tempPlayerScore = playerList[1].highscore;
  //   else 
  //     tempPlayerScore = "1";
  // }


  // // Generates a player with some scores from local database for testing
  // void _testPlayerScores() async {

  //   Future.delayed(const Duration(milliseconds: 1000), () {
  //   setState(() {
    
  //   // Create a few test grades if database is empty
  //   if (playerCount == 0) {
      
  //     // player1.name = 'Bill';
  //     // player1.highscore = "90";

  //     if (player1.id != null) { 
  //       databaseHelper.updatePlayer(player1);
  //     } else {
  //       databaseHelper.insertPlayer(player1);
  //     }

  //     updateTableView();

  //   }
  //   });
  //   });
  // }

  // Update DB (future) & UI
  void updateTableView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Player>> playerListFuture = databaseHelper.getPlayerList();
      playerListFuture.then((playerList) {
        setState(() {
          this.playerList = playerList;
          this.playerCount = playerList.length;
        });
      });
    });
  }

  // Go to chart screen
  void _goToChartScreen() async {
    debugPrint("Going to chart screen");

    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ScoresChartScreen();
    }));

    if (result == true) {
      // do something if needed in future
    }
  }

  // Display a padded text
  Padding _displayText(String displayText, double fontSize, Color textColor, double topPad, double botPad) {
    return Padding(
      padding: EdgeInsets.only(top: topPad, bottom: botPad),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            displayText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: fontSize
            ),
          ),
        ],
      ),
    );
  }

}