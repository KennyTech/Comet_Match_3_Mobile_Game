import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  String _name;
  String _address;
  LatLng _latLong;

  Location(name, address, latLong) : this._name = name, this._address = address, this._latLong = latLong;

  // Location.fromMap(Map<String, dynamic> map) {
  //   this.name = map['name'];
  //   this.address = map['address'];
  //   this.latLng = map['latLng'];
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'name':this.name,
  //     'address': this.address,
  //     'latLng': this.latLng
  //   };
  // }

  set name(String nName) {this._name = nName;}
  set address(String nAddress) {this._address = nAddress;}
  set latLng(LatLng nLatLong) {this._latLong = nLatLong;}
  String get name => this._name;
  String get address => this._address;
  LatLng get latLong => this._latLong;

}
class MapsPage extends StatefulWidget {
  MapsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  var _geolocator = Geolocator();
  var _positionMessage = '';
  //List<Placemark> placemark = [];
  Location location;
  int index = 0;
  final centre = LatLng(43.9457842,-78.895896);
  List<LatLng> paths = [];
  //final locations = [Location('Restaurant', '123 Anywhere St', LatLng(43.9457842,-78.893896)), Location('School', '136 Baker Ave', LatLng(43.9437842,-78.897896))];
  List<Location> locations = [];
  void _updateLocation(userLocation) {
    // location plug-in:
    /*
    _location.getLocation().then((userLocation) {
      setState(() {
        _positionMessage = userLocation.latitude.toString() + ', ' + userLocation.longitude.toString();
      });
      print('New location: ${userLocation.latitude}, ${userLocation.longitude}.');
    });
    */

    // geolocator plug-in:
    setState(() {
      _positionMessage = userLocation.latitude.toString() + ', ' + userLocation.longitude.toString();
    });
    print('New location: ${userLocation.latitude}, ${userLocation.longitude}.');

    // test out reverse geocoding
    _geolocator.placemarkFromCoordinates(userLocation.latitude, userLocation.longitude).then((List<Placemark> places) {
      print('Reverse geocoding results:');
      for (Placemark place in places) {
        location.name = place.name;
        location.address = '${place.subThoroughfare} ${place.thoroughfare}';
        print('\t${place.name}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.locality}, ${place.subAdministrativeArea}');
      }

    });

    
    // testing out forward geocoding
/*     String address = '301 Front St W, Toronto, ON';
    _geolocator.placemarkFromAddress(address).then((List<Placemark> places) {
      print('Forward geocoding results:');
      for (Placemark place in places) {
        print('\t${place.name}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.locality}, ${place.subAdministrativeArea}');
      }
    }); */
  }

    @override 
  void initState() {
        // this is called when the location changes
    /*
    // location plug-in version:
    _location.onLocationChanged().listen((LocationData userLocation) {
      setState(() {
        _positionMessage = userLocation.latitude.toString() + ', ' + userLocation.longitude.toString();
      });
    });
    */
    // geolocator plug-in version:
    _geolocator.checkGeolocationPermissionStatus().then((GeolocationStatus geolocationStatus) {
      print('Geolocation status: $geolocationStatus.');
    });

    _geolocator.getPositionStream(LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 5000))
      .listen((userLocation) {
        _updateLocation(userLocation);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    for (Location l in locations) {
      paths.add(l.latLong);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterMap( 
        options: MapOptions(
          minZoom: 16.0,
          center: centre,
          maxZoom: 32.0
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
                point: paths[0],
                builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.blue,
                    iconSize: 45.0,
                    onPressed: () {
                      print('Icon clicked');
                    },
                  ),
                ),
              ),
            ]
          ),
          PolylineLayerOptions(
            polylines: [
              Polyline(
                points: paths,
                strokeWidth: 2.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
        mapController: MapController()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          locations.add(location);},
        child: Icon(Icons.add),
      ),
    );
  }
// class ShowMap extends StatelessWidget {
//   int index = 0;
//   final centre = LatLng(43.9457842,-78.895896);
//   final paths = [];
//   final locations = [Location('Restaurant', '123 Anywhere St', LatLng(43, -77)), Location('School', '136 Baker Ave', LatLng(43.5, -78.6))];
  
//   //final Locations = [LatLng(43.9457842,-78.893896), LatLng(43.9437842,-78.897896), LatLng(43.9457842,-78.895896)];

//   @override
//   Widget build(BuildContext context) {
//     for (Location l in locations) {
//       paths.add(l.latLng);
//     }
//     return Scaffold(
//       body: FlutterMap(
//         options: MapOptions(
//           minZoom: 16.0,
//           center: centre,
//           maxZoom: 32.0
//         ),
//         layers: [
//           TileLayerOptions(
//             /*
//             // for OpenStreetMaps:
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: ['a', 'b', 'c'],
//             */
//             ///*
//             // for MapBox:
//             urlTemplate: 'https://api.mapbox.com/styles/v1/rfortier/cjzcobx1x2csf1cmppuyzj5ys/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmZvcnRpZXIiLCJhIjoiY2p6Y282cWV4MDg0ZDNibG9zdWZ6M3YzciJ9.p1ePjCH-zs0RdBbLx40pgQ',
//             additionalOptions: {
//               'accessToken': 'pk.eyJ1IjoicmZvcnRpZXIiLCJhIjoiY2p6Y282cWV4MDg0ZDNibG9zdWZ6M3YzciJ9.p1ePjCH-zs0RdBbLx40pgQ',
//               'id': 'mapbox.mapbox-streets-v8'
//             }
//             //*/
//           ),
//           MarkerLayerOptions(
//             markers: [
//               Marker(
//                 width: 45.0,
//                 height: 45.0,
//                 point: centre,
//                 builder: (context) => Container(
//                   child: IconButton(
//                     icon: Icon(Icons.location_on),
//                     color: Colors.blue,
//                     iconSize: 45.0,
//                     onPressed: () {
//                       print('Icon clicked');
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           PolylineLayerOptions(
//             polylines: [
//               Polyline(
//                 points: paths,
//                 strokeWidth: 2.0,
//                 color: Colors.blue,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

}