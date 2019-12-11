/*
* Map 
*
*
*/

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:finalproject/location/location.dart';
//import 'package:geolocator/geolocator.dart';

class MapsPage extends StatefulWidget {
  @override
  MapsPageState createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {

  // ===== Map Setup Test Variables =====
  MapController mapctrl = MapController();

  static List<Location> locationList = [
    new Location('Loc1', '301 Front St W, Toronto, ON', LatLng(43.9453362,-78.8926266)),
    new Location('Loc2', '302 Front St W, Toronto, ON', LatLng(43.9433946,-78.894536))
  ];
  final centre = LatLng(43.9457842,-78.895896);
  static final path = [locationList[0].latlng, locationList[1].latlng];

  static double camZoom = 16.0;
  // ----------

  @override
  Widget build(BuildContext context) {

    // Init markers for points for later
    var pointMarkers = [
      new Marker(
        width: 45.0,
        height: 45.0,
        point: path[0],
        builder: (context) => Container(
          child: IconButton(
            icon: Icon(Icons.brightness_1),
            color: Colors.blue,
            iconSize: 30.0,
            onPressed: () {
              print('Icon clicked');
              // print('Your location: ' + _positionMessage);
            },
          ),
        ),
      ),
      new Marker(
        width: 45.0,
        height: 45.0,
        point: path[1],
        builder: (context) => Container(
          child: IconButton(
            icon: Icon(Icons.brightness_1),
            color: Colors.blue,
            iconSize: 30.0,
            onPressed: () {
              print('Icon clicked');
              // print('Your location: ' + _positionMessage);
            },
          ),
        ),
      ),
    ];

    //debugPrint(locationList[0].toString());

    return Scaffold(

      appBar: AppBar(
        // Title
        title: Text("Lab 9-10 Maps"),
        
        // Zoom Buttons
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.zoom_in, color: Colors.white),
              onPressed: () {
                camZoom += 0.25;
                mapctrl.move(centre,camZoom);
              },
            ),
            IconButton(
              icon: Icon(Icons.zoom_out, color: Colors.white),
              onPressed: () {
                camZoom -= 0.25;
                mapctrl.move(centre,camZoom);
              },
            ),
        ]
      ),

      // Flutter Map, Map Controller, Map Options, Layers (TileLayerOptions, MarkerLayerOptions, PolyLineLayerOptions)
      body: FlutterMap(
        mapController: mapctrl,
        options: MapOptions(
          minZoom: 15.0,
          maxZoom: 19.0,
          center: centre,
        ),
        layers: [
          TileLayerOptions(
            // MapBox API:
            urlTemplate: 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
            additionalOptions: {
              'accessToken': 'pk.eyJ1Ijoia2Vubnl0ZWNoIiwiYSI6ImNrM3BwOTJhazA1bG0zbnBjbTljZGpldTMifQ.4H-8roFdR6SJcKVd2_QLKw', // make your own Mapbox token
              'id': 'mapbox.streets'
            }
          ),
          MarkerLayerOptions( // Markers for each point
            markers: [
              Marker(
                width: 45.0,
                height: 45.0,
                point: centre,
                builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.blue,
                    iconSize: 45.0,
                    onPressed: () {
                      print('Icon clicked');
                      // print('Your location: ' + _positionMessage);
                    },
                  ),
                ),
              ),
              // Display all the points with markers
              pointMarkers[0],
              pointMarkers[1],
            ],
          ),
          PolylineLayerOptions( // Lines between points
            polylines: [
              Polyline(
                points: path,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Update',
        child: Icon(Icons.add),
      ),
    );



  }

}