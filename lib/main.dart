
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/pages.dart';
import 'package:mapavirtual/routes.dart';

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
      initialRoute: Routes.SPLASH,
      routes: appRoutes(),
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
          const ImageConfiguration(size: Size(140, 140)),
          'assets/png/classrooms_level_1.png');
      debugPrint("DEV: Image obtained: ${bitmapClassroom.toJson()}");

      bool isWorking = classroomsGroundOverlaysSet.add(GroundOverlay(
        groundOverlayId: GroundOverlayId("TESTEANDO AASJADASA"),
        bitmapDescriptor: bitmapClassroom,
        height: 144,
        width: 142,
        location: const LatLng(28.70377124721189, -106.13929063844746),
        onTap: () {
          debugPrint("DEV: The ground overlay has been tapped");
        },
      ));
      debugPrint("DEV: Classroom Ground Overlay Set is working? $isWorking");
    }
    openImage();


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
    target: LatLng(28.70377124721189, -106.13929063844746),
    zoom: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        groundOverlays: classroomsGroundOverlaysSet,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}