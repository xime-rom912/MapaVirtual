
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _controllr = TextEditingController();

  Set<GroundOverlay> classroomsGroundOverlaysSet = <GroundOverlay>{};

  Set<Marker> get markers => _markers.values.toSet();

  void onTap(LatLng position){
    final markerId = MarkerId(_markers.length.toString());
    final marker = Marker(
      markerId: markerId,
      position: position,
    );
    _markers[markerId] = marker;
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

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

  final initialCameraPosition = const CameraPosition(
    target: LatLng(28.70377124721189, -106.13929063844746),
    zoom: 18,
  );
}