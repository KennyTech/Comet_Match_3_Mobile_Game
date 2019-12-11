import 'package:latlong/latlong.dart';

class Location {

  Location(this.name, this.address, this.latlng);
  Location.withId(this.id, this.name, this.address, this.latlng);

  int id;
  String name;
  String address;
  LatLng latlng;

  Location.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.address = map['address'];
    this.latlng = map['latlng'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'address': this.address,
      'latlng': this.latlng,
    };
  }

  @override
  String toString() {
    return 'Location{name: $name, address: $address, latlng: $latlng}';
  }
}