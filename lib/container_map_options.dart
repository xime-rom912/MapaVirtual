import 'package:flutter/material.dart';
import 'package:mapavirtual/accordion_layers.dart';

typedef OnRoutDisplayCallback = Function();

class ContainerMapOptions extends StatefulWidget {
  const ContainerMapOptions({required this.onRouteDisplay, super.key});
  final OnRoutDisplayCallback onRouteDisplay;

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () => {showOverlay()},
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.layers),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FloatingActionButton(
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
    return AccordionLayers();
  }

  void hideOverlay() {
    // overlayEntry?overlayEntry.remove():null
  }
}
