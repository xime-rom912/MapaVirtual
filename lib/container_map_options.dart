import 'package:flutter/material.dart';
import 'package:mapavirtual/Controllers/home_contoller.dart';
import 'package:mapavirtual/accordion_layers.dart';

typedef OnRoutDisplayCallback = Function();

class ContainerMapOptions extends StatefulWidget {
  const ContainerMapOptions(
      {required this.homeController, required this.onRouteDisplay, super.key});
  final OnRoutDisplayCallback onRouteDisplay;
  final HomeController homeController;

  @override
  State<ContainerMapOptions> createState() => _ContainerMapOptionsState();
}

class _ContainerMapOptionsState extends State<ContainerMapOptions> {
  OverlayEntry? overlayEntry;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: widget.homeController.visible,
              child: Container(
                margin: const EdgeInsets.only(top: 50, bottom: 30),
                child: const CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              key: const Key("Layers button"),
              onPressed: () => {showOverlay()},
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.layers),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FloatingActionButton(
              key: const Key("Routes button"),
              onPressed: () => {widget.onRouteDisplay()},
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.alt_route_rounded),
            ),
          ),
        ],
      ),
    );
  }

  void showOverlay() {
    final overlay = Overlay.of(context)!;
    overlayEntry = OverlayEntry(builder: (context) => buildOverlay());
    overlay.insert(overlayEntry!);
  }

  Widget buildOverlay() {
    return GestureDetector(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
              maxWidth: MediaQuery.of(context).size.width - 20,
            ),
            child: AccordionLayers(
              homeController: widget.homeController,
            ),
          ),
        ),
      ),
      onTap: () {
        debugPrint("HOLA");
        hideOverlay();
      },
    );
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
