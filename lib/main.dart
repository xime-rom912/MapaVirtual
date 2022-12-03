// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<GroundOverlay> classroomsGroundOverlaysSet = <GroundOverlay>{};

  @override
  void initState() {
    super.initState();

    openImage() async {
      BitmapDescriptor bitmapClassroom = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(150, 150)),
          'assets/png/classrooms_level_1.png');
      debugPrint("DEV: Image obtained: ${bitmapClassroom.toJson()}");

      bool isWorking = classroomsGroundOverlaysSet.add(GroundOverlay(
        groundOverlayId: GroundOverlayId("TESTEANDO AASJADASA"),
        bitmapDescriptor: bitmapClassroom,
        height: 157,
        width: 157,
        location: const LatLng(28.703825788658083, -106.13925163756814),
        onTap: () {
          debugPrint("DEV: The ground overlay has been tapped");
        },
      ));
      debugPrint("DEV: Classroom Ground Overlay Set is working? $isWorking");
    }

    openImage();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.703825788658083, -106.13925163756814),
    zoom: 18,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 40);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        groundOverlays: classroomsGroundOverlaysSet,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
