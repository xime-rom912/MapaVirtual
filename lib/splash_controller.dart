// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapavirtual/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends ChangeNotifier {
  final Permission _locationPermission;
  String? _routeName;
  String? get routeName => _routeName;

  late bool _gpsEnabled;
  bool get gpsEnabled => _gpsEnabled;

  SplashController(this._locationPermission);

  Future<void> checkPermission() async {
    final isGranted = await _locationPermission.isGranted;
    _gpsEnabled = await Geolocator.isLocationServiceEnabled();
    //if(!_gpsEnabled){
    //return Center(
    //child: Column(
    //mainAxisSize: MainAxisSize.min,
    //children: [
    // const Text(
    //"Se necesita acceso a la ubicacion.",
    //textAlign: TextAlign.center,
    //),
    //const SizedBox(height: 10),
    //ElevatedButton(
    //  onPressed: (){},
    //child: const Text("Prender GPS"),
    // ),
    //],
    //),
    //);
    //}else {
    //_routeName = isGranted ? Routes.HOME : Routes.PERMISSIONS;
    //notifyListeners();
    //}
    _routeName = isGranted ? Routes.HOME : Routes.PERMISSIONS;
    notifyListeners();
  }
}
