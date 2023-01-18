// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:google_maps_webservice/directions.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();
  final LatLng fromPoint = LatLng(28.7032543, -106.1403208);
  final LatLng toPoint = LatLng(28.7028573, -106.1389616);
  final Map latitude = {16: 28.704100198007694, 17: 28.70409552666388, 18: 28.70408384830348, 19: 28.704073337778002, 20: 28.704060491578765, 21: 28.704051148887423,
                        22: 28.70399509272181, 23: 28.703978743001187, 24: 28.703943707876963, 25: 28.70392035112095, 26: 28.703905169226772, 27: 28.7038771411086,
                        28: 28.704100198007694, 29: 28.70409552666388, 30: 28.70408384830348, 31: 28.704073337778002, 32: 28.704060491578765, 33: 28.704051148887423,
                        34: 28.70399509272181, 35: 28.703978743001187, 36: 28.703943707876963, 37: 28.70392035112095, 38: 28.703905169226772, 39: 28.7038771411086,
                        40: 28.703756467993674, 41: 28.703752350935098, 42: 28.703740587909735, 43: 28.70373176563983, 44: 28.703728824883044, 45: 28.70371882630932,
                        46: 28.70366225862001, 47: 28.70364006964225, 48: 28.703610873611726, 49: 28.70357934188958, 50: 28.70355014584211, 51: 28.703537299578624,
                        52: 28.703756467993674, 53: 28.703752350935098, 54: 28.703740587909735, 55: 28.70373176563983, 56: 28.703728824883044, 57: 28.70371882630932,
                        58: 28.70366225862001, 59: 28.70364006964225, 60: 28.703610873611726, 61: 28.70357934188958, 62: 28.70355014584211, 63: 28.703537299578624,};
  final Map longitude ={16: -106.138842846805, 17: -106.13894403747099, 18: -106.13902392483887, 19: -106.13911180094352, 20: -106.1391916883114, 21: -106.13927956441604,
                        22: -106.13950724341449, 23: -106.13958979369461, 24: -106.13967367543087, 25: -106.13975356279875, 26: -106.13983877599117, 27: -106.13991466899064,
                        28: -106.138842846805, 29: -106.13894403747099, 30: -106.13902392483887, 31: -106.13911180094352, 32: -106.1391916883114, 33: -106.13927956441604,
                        34: -106.13950724341449, 35: -106.13958979369461, 36: -106.13967367543087, 37: -106.13975356279875, 38: -106.13983877599117, 39: -106.13991466899064,
                        40: -106.13866366145555, 41: -106.13875418600458, 42: -106.13883800503142, 43: -106.13892450626713, 44: -106.13900631363735, 45: -106.13910019094742,
                        46: -106.13931950809999, 47: -106.1394140414853, 48: -106.13949259739704, 49: -106.13957248476491, 50: -106.13965370358892, 51: -106.13974823697423,
                        52: -106.13866366145555, 53: -106.13875418600458, 54: -106.13883800503142, 55: -106.13892450626713, 56: -106.13900631363735, 57: -106.13910019094742,
                        58: -106.13931950809999, 59: -106.1394140414853, 60: -106.13949259739704, 61: -106.13957248476491, 62: -106.13965370358892, 63: -106.13974823697423,};

  // final TextEditingController _controllr = TextEditingController();

  Set<GroundOverlay> classroomsGroundOverlaysSet = <GroundOverlay>{};

  Set<Marker> get markers => _markers.values.toSet();

  void onTap(LatLng position) {
    final markerId = MarkerId(_markers.length.toString());
    final marker = Marker(
      markerId: markerId,
      position: position,
    );
    _markers[markerId] = marker;
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
    findDirections(fromPoint, toPoint);
    onTap(fromPoint);
    onTap(toPoint);
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

  GoogleMapsDirections directionsApi = GoogleMapsDirections(
      apiKey: "AIzaSyBKVePz8SaHa-RGGVf59f8wMPAalC8LvAo"
  );

  Set<maps.Polyline> _route = {};

  Set<maps.Polyline> get currentRoute => _route;

  findDirections(maps.LatLng from, maps.LatLng to) async {
    var origin = Location(lat: from.latitude, lng: from.longitude);
    var destination = Location(lat: to.latitude, lng: to.longitude);

    var result = await directionsApi.directionsWithLocation(
      origin,
      destination,
      travelMode: TravelMode.walking,
    );

    Set<maps.Polyline> newRoute = {};

    if(result.isOkay){
      var route = result.routes[0];
      var leg = route.legs[0];

      List<maps.LatLng> points = [];

      for (var step in leg.steps) {
        points.add(maps.LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(maps.LatLng(step.endLocation.lat, step.endLocation.lng));
      }

      var line = maps.Polyline(
        points: points,
        polylineId: maps.PolylineId("Mejor ruta"),
        color:Colors.lightBlue,
        width: 4,
      );
      newRoute.add(line);
      _route = newRoute;
    }
  }
}
