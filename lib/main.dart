// ignore_for_file: import_of_legacy_library_into_null_safe

// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/Controllers/home_contoller.dart';
import 'package:mapavirtual/pages.dart';
import 'package:mapavirtual/place.dart';
import 'package:mapavirtual/routes.dart';
import 'package:mapavirtual/search_delegate_aulas.dart';
import 'package:provider/provider.dart';

final TextEditingController _cntroller = TextEditingController();
final HomeController _conHome = HomeController();

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

late GoogleMapController _controllerMap;

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  get floatingActionButton => null;


  @override
  Widget build(BuildContext context) {
    double _progress =0.0;
    final List<Place> places = [
      const Place('16', LatLng(28.704100198007694, -106.138842846805),3,0),
      const Place('17', LatLng(28.70409552666388, -106.13894403747099),3,0),
      const Place('18', LatLng(28.70408384830348, -106.13902392483887),3,0),
      const Place('19', LatLng(28.704073337778002, -106.13911180094352),3,0),
      const Place('20', LatLng(28.704060491578765, -106.1391916883114),3,0),
      const Place('21', LatLng(28.704051148887423, -106.13927956441604),3,0),
      const Place('22', LatLng(28.70399509272181, -106.13950724341449),3,0),
      const Place('23', LatLng(28.703978743001187, -106.13958979369461),3,0),
      const Place('24', LatLng(28.703943707876963, -106.13967367543087),3,0),
      const Place('25', LatLng(28.70392035112095, -106.13975356279875),3,0),
      const Place('26', LatLng(28.703905169226772, -106.13983877599117),3,0),
      const Place('27', LatLng(28.7038771411086, -106.13991466899064),3,0),
      const Place('28', LatLng(28.704100198007694, -106.138842846805),3,1),
      const Place('29', LatLng(28.70409552666388, -106.13894403747099),3,1),
      const Place('30', LatLng(28.703943707876963, -106.13967367543087),3,1),
      const Place('31', LatLng(28.704073337778002, -106.13911180094352),3,1),
      const Place('32', LatLng(28.704060491578765, -106.1391916883114),3,1),
      const Place('33', LatLng(28.704051148887423, -106.13927956441604),3,1),
      const Place('34', LatLng(28.70399509272181, -106.13950724341449),3,1),
      const Place('35', LatLng(28.703978743001187, -106.13958979369461),3,1),
      const Place('36', LatLng(28.703943707876963, -106.13967367543087),3,1),
      const Place('37', LatLng(28.70392035112095, -106.13975356279875),3,1),
      const Place('38', LatLng(28.703905169226772, -106.13983877599117),3,1),
      const Place('39', LatLng(28.7038771411086, -106.13991466899064),3,1),
      const Place('40', LatLng(28.703756467993674, -106.13866366145555),4,0),
      const Place('41', LatLng(28.703752350935098, -106.13875418600458),4,0),
      const Place('42', LatLng(28.703740587909735, -106.13883800503142),4,0),
      const Place('43', LatLng(28.70373176563983, -106.13892450626713),4,0),
      const Place('44', LatLng(28.703728824883044, -106.13900631363735),4,0),
      const Place('45', LatLng(28.70371882630932, -106.13910019094742),4,0),
      const Place('46', LatLng(28.70366225862001, -106.13931950809999),4,0),
      const Place('47', LatLng(28.70364006964225, -106.1394140414853),4,0),
      const Place('48', LatLng(28.703610873611726, -106.13949259739704),4,0),
      const Place('49', LatLng(28.70357934188958, -106.13957248476491),4,0),
      const Place('50', LatLng(28.70355014584211, -106.13965370358892),4,0),
      const Place('51', LatLng(28.703537299578624, -106.13974823697423),4,0),
      const Place('52', LatLng(28.703756467993674, -106.13866366145555),4,1),
      const Place('53', LatLng(28.703752350935098, -106.13875418600458),4,1),
      const Place('54', LatLng(28.703740587909735, -106.13883800503142),4,1),
      const Place('55', LatLng(28.70373176563983, -106.13892450626713),4,1),
      const Place('56', LatLng(28.703728824883044, -106.13900631363735),4,1),
      const Place('57', LatLng(28.70371882630932, -106.13910019094742),4,1),
      const Place('58', LatLng(28.70366225862001, -106.13931950809999),4,1),
      const Place('59', LatLng(28.70364006964225, -106.1394140414853),4,1),
      const Place('60', LatLng(28.703610873611726, -106.13949259739704),4,1),
      const Place('61', LatLng(28.70357934188958, -106.13957248476491),4,1),
      const Place('62', LatLng(28.70355014584211, -106.13965370358892),4,1),
      const Place('63', LatLng(28.703537299578624, -106.13974823697423),4,1),
      const Place('Baño 1:E', LatLng(28.703858233086883, -106.13857674669698),4,0),
      const Place('Baño 2:E', LatLng(28.703587294174856, -106.13985893896346),4,0),
      const Place(
          'Escalera 1:D', LatLng(28.704191258575207, -106.13894020473907),3,0),
      const Place(
          'Escalera 2:D', LatLng(28.70398869607634, -106.13986397510558),3,0),
      const Place('Rampa 1:E', LatLng(28.703786733021754, -106.13862478331754),4,0),
      const Place('Rampa 2:E', LatLng(28.70357095907735, -106.13981129271946),4,0),
    ];
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (_, controller, __) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.ARCORE);
                  },
                  child: const Text('Camara'),
                ),
              ],
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: ListTile(
                  onTap: () async {
                    final selectedPlace = await showSearch(
                      context: context,
                      delegate: SearchPlacesDelegate(places),
                    );
                    if(selectedPlace !=null) {
                      controller.onTap(selectedPlace.position);
                    }
                  },
                  title: const Text('Buscar',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            body: GoogleMap(
              markers: controller.markers,
              mapType: MapType.normal,
              initialCameraPosition: controller.initialCameraPosition,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: controller.onMapCreated,
              groundOverlays: controller.classroomsGroundOverlaysSet,
              polylines: controller.currentRoute,
              onTap: controller.onTap,
              zoomControlsEnabled: false,
            ),
            floatingActionButton: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding:
                    EdgeInsets.all(30),
                    child:  CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () => {
                        // TODO: Show the list of places and their rooms
                      },
                      backgroundColor: Colors.deepPurple,
                      child: const Icon(Icons.layers),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FloatingActionButton(
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (buildcontext) {
                            return AlertDialog(
                              title: Text("Punto de origen"),
                              content: Text("Quiere la ruta desde su localizacion o desden punto de origen?"),
                              actions: <Widget>[
                                  ElevatedButton(
                                    child:
                                    const Text("Mi localizacion", style: TextStyle(color: Colors.white),),
                                    onPressed: () async {
                                      await controller.rutaView(true);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ElevatedButton(
                                  child:
                                  const Text("Punto marcado", style: TextStyle(color: Colors.white),),
                                  onPressed: () async{
                                    await controller.rutaView(false);
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          }
                        ),
                      },
                      backgroundColor: Colors.deepPurple,
                      child: const Icon(Icons.alt_route_rounded),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked
            // This trailing comma makes auto-formatting nicer for build methods.
            ),
      ),
    );
  }
}
