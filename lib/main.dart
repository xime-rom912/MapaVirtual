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
  BitmapDescriptor bitmapClassroom = BitmapDescriptor.defaultMarker;
  Set<GroundOverlay> classroomsGroundOverlaysSet = <GroundOverlay>{};

  @override
  void initState() {
    super.initState();

    // drawOverlay() {
    classroomsGroundOverlaysSet.add(GroundOverlay(
      groundOverlayId: GroundOverlayId("TEST"),
      bitmapDescriptor: bitmapClassroom,
      height: 100,
      width: 100,
      location: const LatLng(28.703547206436017, -106.13976759688042),
      onTap: () {
        debugPrint("The image is working, sheesh!");
      },
      transparency: 0,
    ));
    // }

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(100, 100)),
            'assets/png/school.png')
        .then((onValue) {
      debugPrint("JIJIJIJA $onValue");
      bitmapClassroom = onValue;
      // drawOverlay();
    });

    /// put this function on the initState as long as it called to be first on opening
    // fromAsset() async {
    //   /// e.g. location of the asset
    //   const imageURL = "assets/png/school.png";

    //   /// the function to change the icon
    //   final myCustomicon = await BitmapDescriptor.fromAssetImage(
    //       ImageConfiguration.empty, imageURL);
    //   setState(() {
    //     bitmapClassroom = myCustomicon;
    //   });
    // }

    // fromAsset();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.703547206436017, -106.13976759688042),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
        mapType: MapType.hybrid,
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
