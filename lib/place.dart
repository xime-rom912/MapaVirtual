import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place{
  final String name;
  final LatLng position;


  const Place(this.name, this.position);
}