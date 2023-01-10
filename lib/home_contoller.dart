// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();
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
}
