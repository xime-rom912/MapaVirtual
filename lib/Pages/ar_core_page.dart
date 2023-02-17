import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:mapavirtual/pages.dart';
import 'package:mapavirtual/routes.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArCorePage extends StatefulWidget {
  const ArCorePage({Key? key}) : super(key: key);

  @override
  State<ArCorePage> createState() => _ArCoreState();
}

class _ArCoreState extends State<ArCorePage> {
  late ArCoreController arCoreController;

  _onArCoreViewCreated(ArCoreController arcoreController) {
    arCoreController = arcoreController;
    _addSphere(arCoreController);
  }

  _addSphere(ArCoreController arcoreController) {
    final material = ArCoreMaterial(color: Colors.deepOrange);
    final sphere = ArCoreSphere(materials: [material], radius: 0.2);
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(
        0,
        0,
        -1,
      ),
    );
    arcoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }
}

class ArCore extends StatelessWidget {
  const ArCore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.ARCORE,
      routes: appRoutes(),
    );
  }
}
