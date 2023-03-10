import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String name;
  final LatLng position;
  final int building;
  final int floor;

  const Place(this.name, this.position, this.building, this.floor);
}
