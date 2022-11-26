
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/home_contoller.dart';
import 'package:mapavirtual/pages.dart';
import 'package:mapavirtual/routes.dart';
import 'package:provider/provider.dart';

final TextEditingController _cntroller = TextEditingController();

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
              }),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10),
            child: TextField(
              controller: _cntroller,
              //onEditingComplete: () {
                //searching();
              //},
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              autofocus: true,
              decoration: const InputDecoration(
                focusColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
          ),
        ),
        body: Consumer<HomeController>(
          builder:(_,controller, __)=> GoogleMap(
            markers: controller.markers,
            mapType: MapType.hybrid,
            initialCameraPosition: controller.initialCameraPosition,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: controller.onMapCreated,
            groundOverlays: controller.classroomsGroundOverlaysSet,
            onTap: controller.onTap,
          ),
        ),// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}