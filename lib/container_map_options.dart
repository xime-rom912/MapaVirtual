import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/Controllers/home_contoller.dart';
import 'package:mapavirtual/accordion_layers.dart';

typedef OnOverlayDisplayCallback = Function();
typedef OnRouteDisplayCallback = Function();

class ContainerMapOptions extends StatefulWidget {
  const ContainerMapOptions(
      {required this.homeController,
        required this.onOverlayDisplayCallback,
        required this.onRouteDisplay,
        super.key});
  final OnOverlayDisplayCallback onOverlayDisplayCallback;
  final OnRouteDisplayCallback onRouteDisplay;
  final HomeController homeController;

  @override
  State<ContainerMapOptions> createState() => _ContainerMapOptionsState();
}

class _ContainerMapOptionsState extends State<ContainerMapOptions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 230,
              bottom: 230,
              right: 120,
            ),
            child: Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: widget.homeController.visible,
              child: Container(
                margin: const EdgeInsets.all(5),
                child: const CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
          Padding(
            padding:
            const EdgeInsets.only(left: 200, right: 0, top: 0, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FloatingActionButton(
                    key: const Key("Layers button"),
                    onPressed: () => {widget.onOverlayDisplayCallback(),},
                    backgroundColor: Colors.deepPurple,
                    child: const Icon(Icons.layers),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FloatingActionButton(
                    key: const Key("Routes button"),
                    onPressed: () {
                      if(widget.homeController.isButtonEnable) {
                        widget.onRouteDisplay();
                      }else{
                        null;
                      }
                    },
                    backgroundColor: widget.homeController.isButtonEnable ? Colors.deepPurple : Colors.grey,
                    child: const Icon(Icons.alt_route_rounded),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}