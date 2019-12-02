/*
* Scores Chart Screen
*
* This screen displays scores as charts (bar, pie)
*/

import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/rendering.dart';

import 'dart:math';
import 'package:pie_chart/pie_chart.dart';


class ScoresChartScreen extends StatefulWidget {

	ScoresChartScreen();

	@override
  State<StatefulWidget> createState() {

    return ScoresChartScreenState();
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

class ScoresChartScreenState extends State<ScoresChartScreen> {

  List<int> playedTimes = [5,15,1,2,3];
  List<int> avgScore = [75,45,60,35,25];
  List<int> recentScore = [1,2,3,4,5,6,7,8,9,10];

  // Test function to randomize scores (TO-DO: Save/load scores from databases instead)
  void _randomizeScoreAndTimes() {
    setState(() {
        var rng = new Random();
        for (var i = 0; i < 5; i++) 
        {
          avgScore[i] = rng.nextInt(100);
          playedTimes[i] = rng.nextInt(100);
        }
        for (var i = 0; i < 10; i++) 
        {
          recentScore[i] = rng.nextInt(100);
        }
    });
  }

  @override
  Widget build(BuildContext context) {

    double scrWidth = MediaQuery.of(context).size.width;

    var data = [
      new Level('Level 1', avgScore[0], Colors.yellow),
      new Level('Level 2', avgScore[1], Colors.yellow[700]),
      new Level('Level 3', avgScore[2], Colors.orange),
      new Level('Level 4', avgScore[3], Colors.orange[800]),
      new Level('Level 5', avgScore[4], Colors.deepOrange[800]),
    ];

    var recentScoreData = [
      new RecentScore('1', recentScore[0], Colors.yellow),
      new RecentScore('2', recentScore[1], Colors.yellow[600]),
      new RecentScore('3', recentScore[2], Colors.yellow[700]),
      new RecentScore('4', recentScore[3], Colors.orange),
      new RecentScore('5', recentScore[4], Colors.orange[600]),
      new RecentScore('6', recentScore[5], Colors.orange[700]),
      new RecentScore('7', recentScore[6], Colors.orange[800]),
      new RecentScore('8', recentScore[7], Colors.deepOrange[700]),
      new RecentScore('9', recentScore[8], Colors.deepOrange[800]),
      new RecentScore('10', recentScore[9], Colors.deepOrange[900]),
    ];

    var levels = [
      new charts.Series(
        domainFn: (Level clickData, _) => clickData.level,
        measureFn: (Level clickData, _) => clickData.times,
        colorFn: (Level clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var recentScores = [
      new charts.Series(
        domainFn: (RecentScore clickData, _) => clickData.number,
        measureFn: (RecentScore clickData, _) => clickData.score,
        colorFn: (RecentScore clickData, _) => clickData.color,
        id: 'Clicks',
        data: recentScoreData,
      ),
    ];

    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Level 1", () => playedTimes[0].toDouble());
    dataMap.putIfAbsent("Level 2", () => playedTimes[1].toDouble());
    dataMap.putIfAbsent("Level 3", () => playedTimes[2].toDouble());
    dataMap.putIfAbsent("Level 4", () => playedTimes[3].toDouble());
    dataMap.putIfAbsent("Level 5", () => playedTimes[4].toDouble());

    // pie chart
    var pieChartWidget = new Padding(
      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 56.0),
      child: new SizedBox(
        height: 200.0,
        child: PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 2000),
          chartLegendSpacing: 32.0,
          chartRadius: MediaQuery
              .of(context)
              .size
              .width / 2.7,
          showChartValuesInPercentage: true,
          showChartValues: true,
          colorList: [Colors.yellow, Colors.yellow[700], Colors.orange, Colors.orange[800], Colors.deepOrange[800]]
          //chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
        ),
      ),
    );

    
    // bar chart
    var barChartWidget = new Padding(
      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 56.0),
      child: new SizedBox(
        height: 200.0,
        child: new charts.BarChart(
          levels,
          animate: true,
        ),
      ),
    );

    // bar chart
    var barScoresChartWidget = new Padding(
      padding: new EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 56.0),
      child: new SizedBox(
        height: 200.0,
        child: new charts.BarChart(
          recentScores,
          animate: true,
        ),
      ),
    );

    // The scaffold & appbar display
    return new Scaffold(
      appBar: new AppBar( 
        title: new Text("Scores"),
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
                        color: Colors.blue[300],
                        textColor: Colors.grey[300],
                        child: Text(
                          'Charts',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          {};
                          setState(() {
                            debugPrint("Stats clicked");
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5, left: 2.5, right: 5),
                      width: scrWidth/2 - 10,
                      height: 60,
                      child: RaisedButton(
                        elevation: 5,
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          'Tables',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          {};
                          setState(() {
                            debugPrint("Start clicked");
                          });
                        },
                      ),
                    ),
                  ],
                ),

            _displayText("YOUR STATS", 24, Colors.black, 24, 24),

            _displayText("Times Played", 18, Colors.grey[700], 0, 0),
            pieChartWidget,

            _displayText("Average Score (All)", 18, Colors.grey[700], 32, 0),
            barChartWidget,

            _displayText("Scores (Most Recent 10 Games)", 18, Colors.grey[700], 32, 0),
            barScoresChartWidget,

          ],
        ),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: _randomizeScoreAndTimes,
        tooltip: 'Randomize',
        child: new Icon(Icons.add),
      ),

    );
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