// ignore_for_file: import_of_legacy_library_into_null_safe

// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/Controllers/home_contoller.dart';
import 'package:mapavirtual/container_map_options.dart';
import 'package:mapavirtual/pages.dart';
import 'package:mapavirtual/place.dart';
import 'package:mapavirtual/routes.dart';
import 'package:mapavirtual/search_delegate_aulas.dart';
import 'package:provider/provider.dart';

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

//ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  get floatingActionButton => null;
  //reporte internet 45198434
  @override
  Widget build(BuildContext context) {
    final List<Place> places = [
      const Place('16', LatLng(28.704100198007694, -106.138842846805), 3, 0),
      const Place('17', LatLng(28.70409552666388, -106.13894403747099), 3, 0),
      const Place('18', LatLng(28.70408384830348, -106.13902392483887), 3, 0),
      const Place('19', LatLng(28.704073337778002, -106.13911180094352), 3, 0),
      const Place('20', LatLng(28.704060491578765, -106.1391916883114), 3, 0),
      const Place('21', LatLng(28.704051148887423, -106.13927956441604), 3, 0),
      const Place('22', LatLng(28.70399509272181, -106.13950724341449), 3, 0),
      const Place('23', LatLng(28.703978743001187, -106.13958979369461), 3, 0),
      const Place('24', LatLng(28.703943707876963, -106.13967367543087), 3, 0),
      const Place('25', LatLng(28.70392035112095, -106.13975356279875), 3, 0),
      const Place('26', LatLng(28.703905169226772, -106.13983877599117), 3, 0),
      const Place('27', LatLng(28.7038771411086, -106.13991466899064), 3, 0),
      const Place('28', LatLng(28.704100198007694, -106.138842846805), 3, 1),
      const Place('29', LatLng(28.70409552666388, -106.13894403747099), 3, 1),
      const Place('30', LatLng(28.703943707876963, -106.13967367543087), 3, 1),
      const Place('31', LatLng(28.704073337778002, -106.13911180094352), 3, 1),
      const Place('32', LatLng(28.704060491578765, -106.1391916883114), 3, 1),
      const Place('33', LatLng(28.704051148887423, -106.13927956441604), 3, 1),
      const Place('34', LatLng(28.70399509272181, -106.13950724341449), 3, 1),
      const Place('35', LatLng(28.703978743001187, -106.13958979369461), 3, 1),
      const Place('36', LatLng(28.703943707876963, -106.13967367543087), 3, 1),
      const Place('37', LatLng(28.70392035112095, -106.13975356279875), 3, 1),
      const Place('38', LatLng(28.703905169226772, -106.13983877599117), 3, 1),
      const Place('39', LatLng(28.7038771411086, -106.13991466899064), 3, 1),
      const Place('40', LatLng(28.703756467993674, -106.13866366145555), 4, 0),
      const Place('41', LatLng(28.703752350935098, -106.13875418600458), 4, 0),
      const Place('42', LatLng(28.703740587909735, -106.13883800503142), 4, 0),
      const Place('43', LatLng(28.70373176563983, -106.13892450626713), 4, 0),
      const Place('44', LatLng(28.703728824883044, -106.13900631363735), 4, 0),
      const Place('45', LatLng(28.70371882630932, -106.13910019094742), 4, 0),
      const Place('46', LatLng(28.70366225862001, -106.13931950809999), 4, 0),
      const Place('47', LatLng(28.70364006964225, -106.1394140414853), 4, 0),
      const Place('48', LatLng(28.703610873611726, -106.13949259739704), 4, 0),
      const Place('49', LatLng(28.70357934188958, -106.13957248476491), 4, 0),
      const Place('50', LatLng(28.70355014584211, -106.13965370358892), 4, 0),
      const Place('51', LatLng(28.703537299578624, -106.13974823697423), 4, 0),
      const Place('52', LatLng(28.703756467993674, -106.13866366145555), 4, 1),
      const Place('53', LatLng(28.703752350935098, -106.13875418600458), 4, 1),
      const Place('54', LatLng(28.703740587909735, -106.13883800503142), 4, 1),
      const Place('55', LatLng(28.70373176563983, -106.13892450626713), 4, 1),
      const Place('56', LatLng(28.703728824883044, -106.13900631363735), 4, 1),
      const Place('57', LatLng(28.70371882630932, -106.13910019094742), 4, 1),
      const Place('58', LatLng(28.70366225862001, -106.13931950809999), 4, 1),
      const Place('59', LatLng(28.70364006964225, -106.1394140414853), 4, 1),
      const Place('60', LatLng(28.703610873611726, -106.13949259739704), 4, 1),
      const Place('61', LatLng(28.70357934188958, -106.13957248476491), 4, 1),
      const Place('62', LatLng(28.70355014584211, -106.13965370358892), 4, 1),
      const Place('63', LatLng(28.703537299578624, -106.13974823697423), 4, 1),
      const Place(
          'Baño 1:E', LatLng(28.703858233086883, -106.13857674669698), 4, 0),
      const Place(
          'Baño 2:E', LatLng(28.703587294174856, -106.13985893896346), 4, 0),
      const Place('Gimnasio', LatLng(28.70306287380711, -106.14051695913075), 2, 2),
      const Place('Impresiones', LatLng(28.703133746475338, -106.14050086587667), 2, 2),
      const Place('Enfermeria', LatLng(28.70335224572705, -106.140332557261), 2, 2),
      const Place('Baños 3:C', LatLng(28.703460759990705, -106.14021353423594), 2, 2),
      const Place('Laboratorio de Mineralogía', LatLng(28.703220205184003, -106.14086128771305), 2, 0),
      const Place('Laboratorio de Mineralogía', LatLng(28.703188738927537, -106.14077780395746), 2, 0),
      const Place('Laboratorio de Geofísica', LatLng(28.703188738927537, -106.14077780395746), 2, 0),
      const Place('Almacen de deportes', LatLng(28.703232556422243, -106.14056590944527), 2, 0),
      const Place('Laboratorio de Topografía', LatLng(28.703220205184003, -106.14053539931773), 2, 0),
      const Place('Baños 1:C', LatLng(28.70344958508529, -106.14047303795815), 2, 0),
      const Place('Laboratorio de materiales', LatLng(28.70358015495838, -106.14050254225731), 2, 0),
      const Place('Patio de pruebas', LatLng(28.703383711934332, -106.14062726497652), 2, 0),
      const Place('Laboratorio de Fotogrametría', LatLng(28.70322990972845, -106.14082708954811), 2, 1),
      const Place('Laboratorio de Geología', LatLng(28.703132276088496, -106.14071108400822), 2, 1),
      const Place('Aula de Posgrado', LatLng(28.70347105266569, -106.14036843180656), 2, 1),
      const Place('Laboratorio de Hidráulica', LatLng(28.703553099953, -106.14038754254578), 2, 1),
      const Place('Laboratorio de Sanitaria', LatLng(28.703571920827038, -106.14051662385464), 2, 1),
      const Place('Laboratorio de Sanitaria', LatLng(28.703571920827038, -106.14051662385464), 2, 1),
      const Place('Laboratorio de Química', LatLng(28.703229615651363, -106.14085022360086), 2, 3),
      const Place('Laboratorio de Física', LatLng(28.703191679699568, -106.14077344536781), 2, 3),
      const Place('LC', LatLng(28.70326549305051, -106.13991882652044), 1, 0),
      const Place('LC4', LatLng(28.703602798816167, -106.14039257168768), 2, 3),
      const Place('LC5', LatLng(28.703132570165863, -106.14074192941187), 2, 3),
      const Place('LC6', LatLng(28.703204325018383, -106.14068023860455), 2, 3),
      const Place('LC7', LatLng(28.70339518092342, -106.14025712013246), 2, 4),
      const Place('LC9', LatLng(28.703100515728153, -106.14009417593479), 1, 0),
      const Place('LC10',  LatLng(28.703159331202677, -106.14003919064999), 1, 0),
      const Place('LC11', LatLng(28.703207853944285, -106.13998152315617), 1, 0),
      const Place('LC12', LatLng(28.703271080513176, -106.14036206156015), 2, 2),
      const Place('LC13', LatLng(28.703414884055565, -106.14027924835682), 2, 2),
      const Place('Laboratorio de Automática', LatLng(28.703101103883068, -106.14070437848568), 2, 3),
      const Place('Laboratorio de Electrónica', LatLng(28.703498989921297, -106.14033523947), 2, 3),
      const Place('Laboratorio de Redes', LatLng(28.703503695142544, -106.14046365022661), 2, 3),
      const Place('Laboratorio de Simulación y Aleado Mecánico', LatLng(28.703503695142544, -106.14056020975113), 2, 3),
      const Place('Clubes Estudiantiles', LatLng(28.70353310277064, -106.14058770239353), 2, 3),
      const Place('Laboratorio Isotópico', LatLng(28.703551923648263, -106.14054512232543), 2, 3),
      const Place('Laboratorio de Matemáticas y Sistemas Dinámicos', LatLng(28.70366573107058, -106.14044319838285), 2, 3),
      const Place('Laboratorio de Sensores', LatLng(28.703182269228773, -106.14050522446632), 2, 4),
      const Place('Aula', LatLng(28.70328460805321, -106.14034228026865), 2, 4),
      const Place('Baños 4:C', LatLng(28.703442821326156, -106.14020481705666), 2, 4),
      const Place('S1', LatLng(28.70292936250924, -106.14022560417652), 1, 0),
      const Place('S2', LatLng(28.70286466534326, -106.14026516675949), 1, 0),
      const Place('S3', LatLng(28.702799085902402, -106.14031679928303), 1, 0),
      const Place('S4', LatLng(28.702727918929003, -106.14036709070206), 1, 0),
      const Place('S5', LatLng(28.702727918929003, -106.14036709070206), 1, 0),
      const Place('S6', LatLng(28.702799085902402, -106.14031679928303), 1, 0),
      const Place('S7', LatLng(28.70286466534326, -106.14026516675949), 1, 0),
      const Place('S8', LatLng(28.70292936250924, -106.14022560417652), 1, 0),
      const Place('S9', LatLng(28.703100515728153, -106.14009417593479), 1, 0),
      const Place('S10',  LatLng(28.703159331202677, -106.14003919064999), 1, 0),
      const Place('S11', LatLng(28.703207853944285, -106.13998152315617), 1, 0),
      const Place('S12', LatLng(28.70326549305051, -106.13991882652044), 1, 0),
      const Place('Biblioteca', LatLng(28.70308816447431, -106.13823037594557), 1, 0),
      const Place('Administrativos', LatLng(28.70276173795133, -106.13883789628744), 1, 0),
      const Place('Edificio A - Cubiculos de Maestros', LatLng(28.702639107183625, -106.13968346267939), 1, 0),
      const Place('Auditorio Fernando Aguilera Baca', LatLng(28.703269021974346, -106.13876581192017), 1, 0),
      const Place('Cafetería', LatLng(28.7042227092798, -106.13800305873156), 1, 0),
    ];
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (_, controller, __) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
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
                  if (selectedPlace != null) {
                    controller.onTap(selectedPlace.position);
                  }
                },
                title: const Text(
                  'Buscar',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
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
          floatingActionButton: ContainerMapOptions(
            homeController: controller,
            onRouteDisplay: () => handleRouteDisplay(context, controller),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }

  handleRouteDisplay(context, controller) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: const Text("Punto de origen"),
          content: const Text(
              "Quiere la ruta desde su localizacion o desde punto de marcado?"),
          actions: <Widget>[
            ElevatedButton(
              key: const Key("My location"),
              child: const Text(
                "Mi localizacion",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                controller.loadProgress();
                controller.rutaView(true);
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              key: const Key("Route to destiny"),
              child: const Text(
                "Ruta al destino",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                controller.loadProgress();
                controller.rutaView(false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}