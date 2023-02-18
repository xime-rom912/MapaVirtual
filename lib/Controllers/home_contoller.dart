// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/directions_repository.dart';

class HomeController extends ChangeNotifier {
  final Completer<GoogleMapController> _controller = Completer();
  final LatLng fromPoint = const LatLng(28.704521, -106.138989);
  final LatLng toPoint = const LatLng(28.703741, -106.140353);
  late GoogleMapController _controllerMap ;
  late bool flag = true;

  final Map<MarkerId, Marker> _markers = {};

  Set<GroundOverlay> classroomsGroundOverlaysSet = <GroundOverlay>{};

  Set<Marker> get markers => _markers.values.toSet();

  Set<maps.Polyline> _route = {};

  Set<maps.Polyline> get currentRoute => _route;

  Future<void> rutaView() async {
    Position position =
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LatLng myLocation = LatLng(position.latitude,position.longitude);
    LatLng fromPoint = markers.first.position;
    LatLng toPoint = markers.last.position;


    if(myLocation != null){
      findDirections(myLocation! as maps.LatLng, fromPoint!);
    }else if (fromPoint != null && toPoint != null) {
      findDirections(fromPoint!, toPoint!);
      notifyListeners();
    }
  }

  void marker(String id, LatLng position){
    final markerId = MarkerId(id);
    final marker = Marker(
      markerId: markerId,
      position: position,
      draggable: false,
      anchor: const Offset(0.5, 1.5),
      visible: true,
    );
    _markers[markerId] = marker;
  }

  void onTap(LatLng position/*, int building, int level*/) {
    currentRoute.clear();
    if(flag) {
      const id = '0';
      marker(id,position);
      //cambio(building,level)
      flag = false;
    }else{
      const id = '1';
      marker(id,position);
      //cambio(building,level)
      flag = true;
    }
    notifyListeners();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    debugPrint("THE MAP HAS BEEN CREATED AAAAAAAAAAAAAAAAAAAAAAAAAA");
    // await openClassroomsImage();
    await loadImageOnMap(
        classroomsImageFilename, classroomsPosition, 0, classroomsSize);
    await loadImageOnMap(
        edificioCImageFilename, edificioCPosition, 1, edificioCSize);
    _controller.complete(controller);
    debugPrint("GroundOverlaySet $classroomsGroundOverlaysSet");
    notifyListeners();
  }

  loadImageOnMap(
      String imageFilename, LatLng coords, int id, Size imageSize) async {
    BitmapDescriptor bitmap = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: imageSize), imageFilename);
    debugPrint("DEV: Image obtained: ${bitmap.toJson()}");

    bool isWorking = classroomsGroundOverlaysSet.add(GroundOverlay(
      groundOverlayId: GroundOverlayId("$imageFilename $id"),
      bitmapDescriptor: bitmap,
      height: imageSize.height,
      width: imageSize.width,
      location: coords,
      onTap: () {
        debugPrint("DEV: The ground overlay has been tapped");
      },
    ));
    debugPrint("DEV: Classroom Ground Overlay Set is working? $isWorking");
  }

  final classroomsImageFilename = "assets/png/classrooms_level_1.png";
  final classroomsPosition =
      const LatLng(28.70377124721189, -106.13929063844746);
  final classroomsSize = const Size(140, 140);

  final edificioCImageFilename = "assets/png/laboratories_level_0_01.png";
  final edificioCPosition =
      const LatLng(28.703168888427548, -106.14043582907642);
  final edificioCSize = const Size(110, 110);

  final initialCameraPosition = const CameraPosition(
    target: LatLng(28.703206295599326, -106.14058572967595),
    // target: LatLng(28.70377124721189, -106.13929063844746),
    zoom: 18,
  );

  findDirections(maps.LatLng from, maps.LatLng to) async {

    final directions = await DirectionsRepository()
        .getDirections(origin: from, destination: to);

    Set<maps.Polyline> newRoute = {};

    if(directions != null){
      var line = maps.Polyline(
        points: directions.polylinePoints
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList(),
        polylineId: maps.PolylineId("overview_polyline"),
        color:Colors.amber,
        width: 4,
      );
      newRoute.add(line);
      _route = newRoute;
    }
    notifyListeners();
  }
}