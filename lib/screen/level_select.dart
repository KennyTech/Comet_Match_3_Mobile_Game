/*
* Level Select Screen
*
* The screen to select level prior to game start.
*/

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/screen/play_screen.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

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
  final centre = LatLng(0,0);
  final levels = [LatLng(36.204824, 138.252924), LatLng(37.09024,-95.712891), LatLng(61.52401, 105.318756),
                  LatLng(46.227638,2.213749), LatLng(35.86166, 104.195397)];

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
          body: FlutterMap( 
        options: MapOptions(
          minZoom: 1.0,
          center: centre,
          maxZoom: 2.0
        ),
        layers: [
          TileLayerOptions(
            /*
            // for OpenStreetMaps:
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            */
            ///*
            // for MapBox:
            urlTemplate: 'https://api.mapbox.com/styles/v1/rfortier/cjzcobx1x2csf1cmppuyzj5ys/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmZvcnRpZXIiLCJhIjoiY2p6Y282cWV4MDg0ZDNibG9zdWZ6M3YzciJ9.p1ePjCH-zs0RdBbLx40pgQ',
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoicmZvcnRpZXIiLCJhIjoiY2p6Y282cWV4MDg0ZDNibG9zdWZ6M3YzciJ9.p1ePjCH-zs0RdBbLx40pgQ',
              'id': 'mapbox.mapbox-streets-v8'
            }
            //*/
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 45.0,
                height: 45.0,
                point: levels[0],
                builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.blue,
                    iconSize: 45.0,
                    onPressed: () {
                      _goToPlayScreen(1); // _goToPlayScreen(int level)
                          setState(() {
                            debugPrint("Start clicked");
                          });
                    },
                  ),
                ),
              ),
              Marker(
                width: 45.0,
                height: 45.0,
                point: levels[1],
                builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.blue,
                    iconSize: 45.0,
                    onPressed: () {
                      _goToPlayScreen(1); // _goToPlayScreen(int level)
                          setState(() {
                            debugPrint("Start clicked");
                          });
                    },
                  ),
                ),
              ),
              Marker(
                width: 45.0,
                height: 45.0,
                point: levels[2],
                builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.blue,
                    iconSize: 45.0,
                    onPressed: () {
                      _goToPlayScreen(1); // _goToPlayScreen(int level)
                          setState(() {
                            debugPrint("Start clicked");
                          });
                    },
                  ),
                ),
              ),
              Marker(
                width: 45.0,
                height: 45.0,
                point: levels[3],
                builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.blue,
                    iconSize: 45.0,
                    onPressed: () {
                      _goToPlayScreen(1); // _goToPlayScreen(int level)
                          setState(() {
                            debugPrint("Start clicked");
                          });
                    },
                  ),
                ),
              ),
              Marker(
                width: 45.0,
                height: 45.0,
                point: levels[4],
                builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.blue,
                    iconSize: 45.0,
                    onPressed: () {
                      _goToPlayScreen(1); // _goToPlayScreen(int level)
                          setState(() {
                            debugPrint("Start clicked");
                          });
                    },
                  ),
                ),
              ),
            ]
          ),
        ],
        mapController: MapController(),
        
      ),
      
          // body: SingleChildScrollView(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Text(
          //         'Select Level',
          //         style: TextStyle(fontSize: 18),
          //       ),
          //       SizedBox(
          //         height: 200.0,
          //         child: ListView.builder(
          //           physics: ClampingScrollPhysics(),
          //           shrinkWrap: true,
          //           scrollDirection: Axis.horizontal,
          //           itemCount: 5, // 5 levels
          //           itemBuilder: (BuildContext context, int index) => Card(
          //             color: _selectedLevelColor[index]
          //               ? Colors.blue[100]
          //               : Colors.white,
          //             child: InkWell(
          //               onTap: () {
          //                 debugPrint('Selected a grade');
          //                 _selectedLevel = index; // Set as selected
          //                 setState(() {
          //                   _removePrevColor(); // remove previous selection highlight
          //                   _selectedLevelColor[_selectedLevel] =
          //                     !_selectedLevelColor[_selectedLevel]; // highlight new selection
          //                 });
          //               },
          //               child: Text("      Level $index      ")),
          //           )),
          //       ),
          //       Text(
          //         'Level Information',
          //         style: TextStyle(fontSize: 18),
          //       ),
          //       Card(
          //         child: ListTile(
          //             title: Text('Summary: '),
          //             subtitle: Text(
          //                 'Summary of selected level / difficulty / stuff')), // TO-DO: Update information based on selected level
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Container(
          //             margin: EdgeInsets.all(20.0),
          //             child: RaisedButton(
          //               color: Colors.blue,
          //               textColor: Colors.white,
          //               child: Text(
          //                 'Back',
          //                 textScaleFactor: 1.5,
          //               ),
          //               onPressed: () {
          //                 goToPreviousScreen();
          //                 setState(() {
          //                   debugPrint("Back clicked");
          //                 });
          //               },
          //             ),
          //           ),
          //           Container(
          //             margin: EdgeInsets.all(20.0),
          //             child: RaisedButton(
          //               color: Colors.blue,
          //               textColor: Colors.white,
          //               child: Text(
          //                 'Start',
          //                 textScaleFactor: 1.5,
          //               ),
          //               onPressed: () {
                          // _goToPlayScreen(1); // _goToPlayScreen(int level)
                          // setState(() {
                          //   debugPrint("Start clicked");
                          // });
          //               },
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
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
