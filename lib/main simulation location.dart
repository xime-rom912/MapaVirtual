// ignore_for_file: import_of_legacy_library_into_null_safe

// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/Controllers/home_contoller.dart';
import 'package:mapavirtual/accordion_layers.dart';
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

// //ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
      child: Consumer<HomeController>(
        builder: (_, HomeController controller, __) {
          return HomePage(homeController: controller);
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({required this.homeController, super.key});
  final HomeController homeController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OverlayEntry? overlayEntry;
  late final List<BuildingModel> buildings;
  late final List<Place> places;
  late bool _visible = true;
  late Position position;
  late String text1 = 'Punto de partida';
  late String text2 = 'Punto de llegada';
  late bool flag = false;
  late bool isLocationServiceEnabled;

  @override
  void initState() {
    super.initState();

    debugPrint("RELOAD");

    buildings = <BuildingModel>[
      BuildingModel(
        floorToRender: 0,
        idOfMapRender: "administrativos",
        name: "Administrativos",
        floors: <FloorModel>[
          const FloorModel(
            name: "Nivel 1",
            mapsImage: MapsImage(
              id: "A1",
              coords: LatLng(28.70274924701189, -106.13886063804746),
              filename: "assets/png/admin_1.png",
              size: Size(82, 50),
            ),
          ),
          const FloorModel(
            name: "Nivel 2",
            mapsImage: MapsImage(
              id: "A2",
              coords: LatLng(28.70274924701189, -106.13886063804746),
              filename: "assets/png/admin_2.png",
              size: Size(82, 50),
            ),
          ),
        ],
        onChangeBuildingFloor: (BuildingModel building, FloorModel floor) =>
            reloadBuildingFloor(building, floor),
      ),
      BuildingModel(
        floorToRender: 0,
        idOfMapRender: "cubiculos",
        name: "Edificio A - Cubiculos",
        floors: <FloorModel>[
          const FloorModel(
            name: "Nivel 1",
            mapsImage: MapsImage(
              id: "A",
              coords: LatLng(28.70269424721189, -106.13969863844746),
              filename: "assets/png/cub_1.png",
              size: Size(48, 53),
            ),
          ),
          const FloorModel(
            name: "Nivel 2",
            mapsImage: MapsImage(
              id: "A",
              coords: LatLng(28.70269424721189, -106.13969863844746),
              filename: "assets/png/cub_2.png",
              size: Size(48, 53),
            ),
          ),
          const FloorModel(
            name: "Nivel 3",
            mapsImage: MapsImage(
              id: "A",
              coords: LatLng(28.70269424721189, -106.13969863844746),
              filename: "assets/png/cub_3.png",
              size: Size(48, 53),
            ),
          )
        ],
        onChangeBuildingFloor: (BuildingModel building, FloorModel floor) {
          final MapsImage image = floor.mapsImage;
          widget.homeController.replaceImageOnMap(
              idRender: building.idOfMapRender, image: image);
        },
      ),
      BuildingModel(
        floorToRender: 0,
        idOfMapRender: "Edificio B",
        name: "Edificio B - Posgrado",
        floors: <FloorModel>[
          const FloorModel(
            name: "Nivel 1",
            mapsImage: MapsImage(
              id: "EL1",
              coords: LatLng(28.70321537827747, -106.14054450878434),
              filename: "assets/png/classroom_level_B_0.png",
              size: Size(145, 145),
            ),
          ),
          const FloorModel(
            name: "Nivel 2",
            mapsImage: MapsImage(
              id: "EL2",
              coords: LatLng(28.70321537827747, -106.14054450878434),
              filename: "assets/png/classroom_level_B_1.png",
              size: Size(145, 145),
            ),
          ),
        ],
        onChangeBuildingFloor: (BuildingModel building, FloorModel floor) =>
            reloadBuildingFloor(building, floor),
      ),
      BuildingModel(
        floorToRender: 2,
        idOfMapRender: "Laboratorios",
        name: "Edificio C - Laboratorios",
        floors: <FloorModel>[
          const FloorModel(
            name: "Subnivel 2",
            mapsImage: MapsImage(
              id: "SL2",
              coords: LatLng(28.70324537827747, -106.14056450878434),
              filename: "assets/png/laboratories_level_s2_03.png",
              size: Size(145, 145),
            ),
          ),
          const FloorModel(
            name: "Subnivel 1",
            mapsImage: MapsImage(
              id: "SL1",
              coords: LatLng(28.70324537827747, -106.14056450878434),
              filename: "assets/png/laboratories_level_s1_03.png",
              size: Size(145, 145),
            ),
          ),
          const FloorModel(
            name: "Nivel 0",
            mapsImage: MapsImage(
              id: "L0",
              coords: LatLng(28.703230537827747, -106.14046450878434),
              filename: "assets/png/laboratories_level_0_03.png",
              size: Size(165, 165),
            ),
          ),
          const FloorModel(
            name: "Nivel 1",
            mapsImage: MapsImage(
              id: "L1",
              coords: LatLng(28.70324537827747, -106.14056450878434),
              filename: "assets/png/laboratories_level_1_03.png",
              size: Size(145, 145),
            ),
          ),
          const FloorModel(
            name: "Nivel 2",
            mapsImage: MapsImage(
              id: "L2",
              coords: LatLng(28.70324537827747, -106.14056450878434),
              filename: "assets/png/laboratories_level_2_03.png",
              size: Size(145, 145),
            ),
          ),
        ],
        onChangeBuildingFloor: (BuildingModel building, FloorModel floor) =>
            reloadBuildingFloor(building, floor),
      ),
      BuildingModel(
        floorToRender: 0,
        idOfMapRender: "EdificioD",
        name: "Edificio D - Aulas",
        floors: <FloorModel>[
          const FloorModel(
            name: "Nivel 1",
            mapsImage: MapsImage(
              id: "DL1",
              coords: LatLng(28.70384124721189, -106.13930063844746),
              filename: "assets/png/classrooms_level_D_1.png",
              size: Size(170, 106),
            ),
          ),
          const FloorModel(
            name: "Nivel 2",
            mapsImage: MapsImage(
              id: "DL2",
              coords: LatLng(28.70384124721189, -106.13930063844746),
              filename: "assets/png/classrooms_level_D_2.png",
              size: Size(170, 106),
            ),
          ),
        ],
        onChangeBuildingFloor: (BuildingModel building, FloorModel floor) =>
            reloadBuildingFloor(building, floor),
      ),
      BuildingModel(
        floorToRender: 0,
        idOfMapRender: "EdificioE",
        name: "Edificio E - Aulas",
        floors: <FloorModel>[
          const FloorModel(
            name: "Nivel 1",
            mapsImage: MapsImage(
              id: "EL1",
              coords: LatLng(28.70388124721189, -106.13926063844746),
              filename: "assets/png/classrooms_level_E_1.png",
              size: Size(164, 100),
            ),
          ),
          const FloorModel(
            name: "Nivel 2",
            mapsImage: MapsImage(
              id: "EL2",
              coords: LatLng(28.70388124721189, -106.13926063844746),
              filename: "assets/png/classrooms_level_E_2.png",
              size: Size(164, 100),
            ),
          ),
        ],
        onChangeBuildingFloor: (BuildingModel building, FloorModel floor) =>
            reloadBuildingFloor(building, floor),
      ),
      BuildingModel(
        floorToRender: 0,
        idOfMapRender: "edificios",
        name: "edificios",
        floors: <FloorModel>[
          const FloorModel(
            name: "Nivel 1",
            mapsImage: MapsImage(
              id: "EF",
              coords: LatLng(28.70365123611189, -106.13838192842746),
              filename: "assets/png/building.png",
              size: Size(110, 168),
            ),
          ),
        ],
        onChangeBuildingFloor: (BuildingModel building, FloorModel floor) =>
            reloadBuildingFloor(building, floor),
      ),
    ];

    for (int i = 0; i < buildings.length; i++) {
      var floorToRender = buildings[i].floorToRender;
      widget.homeController.loadImageOnMap(
        idRender: buildings[i].idOfMapRender,
        image: buildings[i].floors[floorToRender].mapsImage,
      );
    }

    places = <Place>[
      const Place('Mi ubicacion', LatLng(28.70276173795133, -106.13883789628744),0,0),
      const Place('16', LatLng(28.704100198007694, -106.138842846805), 2, 0),
      const Place('17', LatLng(28.70409552666388, -106.13894403747099), 2, 0),
      const Place('18', LatLng(28.70408384830348, -106.13902392483887), 2, 0),
      const Place('19', LatLng(28.704073337778002, -106.13911180094352), 2, 0),
      const Place('20', LatLng(28.704060491578765, -106.1391916883114), 2, 0),
      const Place('21', LatLng(28.704051148887423, -106.13927956441604), 2, 0),
      const Place('22', LatLng(28.70399509272181, -106.13950724341449), 2, 0),
      const Place('23', LatLng(28.703978743001187, -106.13958979369461), 2, 0),
      const Place('24', LatLng(28.703943707876963, -106.13967367543087), 2, 0),
      const Place('25', LatLng(28.70392035112095, -106.13975356279875), 2, 0),
      const Place('26', LatLng(28.703905169226772, -106.13983877599117), 2, 0),
      const Place('27', LatLng(28.7038771411086, -106.13991466899064), 2, 0),
      const Place('28', LatLng(28.704100198007694, -106.138842846805), 2, 1),
      const Place('29', LatLng(28.70409552666388, -106.13894403747099), 2, 1),
      const Place('30', LatLng(28.703943707876963, -106.13967367543087), 2, 1),
      const Place('31', LatLng(28.704073337778002, -106.13911180094352), 2, 1),
      const Place('32', LatLng(28.704060491578765, -106.1391916883114), 2, 1),
      const Place('33', LatLng(28.704051148887423, -106.13927956441604), 2, 1),
      const Place('34', LatLng(28.70399509272181, -106.13950724341449), 2, 1),
      const Place('35', LatLng(28.703978743001187, -106.13958979369461), 2, 1),
      const Place('36', LatLng(28.703943707876963, -106.13967367543087), 2, 1),
      const Place('37', LatLng(28.70392035112095, -106.13975356279875), 2, 1),
      const Place('38', LatLng(28.703905169226772, -106.13983877599117), 2, 1),
      const Place('39', LatLng(28.7038771411086, -106.13991466899064), 2, 1),
      const Place('40', LatLng(28.703756467993674, -106.13866366145555), 3, 0),
      const Place('41', LatLng(28.703752350935098, -106.13875418600458), 3, 0),
      const Place('42', LatLng(28.703740587909735, -106.13883800503142), 3, 0),
      const Place('43', LatLng(28.70373176563983, -106.13892450626713), 3, 0),
      const Place('44', LatLng(28.703728824883044, -106.13900631363735), 3, 0),
      const Place('45', LatLng(28.70371882630932, -106.13910019094742), 3, 0),
      const Place('46', LatLng(28.70366225862001, -106.13931950809999), 3, 0),
      const Place('47', LatLng(28.70364006964225, -106.1394140414853), 3, 0),
      const Place('48', LatLng(28.703610873611726, -106.13949259739704), 3, 0),
      const Place('49', LatLng(28.70357934188958, -106.13957248476491), 3, 0),
      const Place('50', LatLng(28.70355014584211, -106.13965370358892), 3, 0),
      const Place('51', LatLng(28.703537299578624, -106.13974823697423), 3, 0),
      const Place('52', LatLng(28.703756467993674, -106.13866366145555), 3, 1),
      const Place('53', LatLng(28.703752350935098, -106.13875418600458), 3, 1),
      const Place('54', LatLng(28.703740587909735, -106.13883800503142), 3, 1),
      const Place('55', LatLng(28.70373176563983, -106.13892450626713), 3, 1),
      const Place('56', LatLng(28.703728824883044, -106.13900631363735), 3, 1),
      const Place('57', LatLng(28.70371882630932, -106.13910019094742), 3, 1),
      const Place('58', LatLng(28.70366225862001, -106.13931950809999), 3, 1),
      const Place('59', LatLng(28.70364006964225, -106.1394140414853), 3, 1),
      const Place('60', LatLng(28.703610873611726, -106.13949259739704), 3, 1),
      const Place('61', LatLng(28.70357934188958, -106.13957248476491), 3, 1),
      const Place('62', LatLng(28.70355014584211, -106.13965370358892), 3, 1),
      const Place('63', LatLng(28.703537299578624, -106.13974823697423), 3, 1),
      const Place('Administrativos', LatLng(28.70276173795133, -106.13883789628744), 4, 0),
      const Place('Almacen de deportes', LatLng(28.703232556422243, -106.14056590944527), 1, 0),
      const Place('Auditorio Fernando Aguilera Baca', LatLng(28.703269021974346, -106.13876581192017), 4, 0),
      const Place('Aula', LatLng(28.70328460805321, -106.14034228026865), 1, 4),
      const Place('Aula de Posgrado', LatLng(28.70347105266569, -106.14036843180656), 1, 1),
      const Place('Baños 4:C', LatLng(28.703442821326156, -106.14020481705666), 1, 4),
      const Place('Baños 1:C', LatLng(28.70344958508529, -106.14047303795815), 1, 0),
      const Place('Baños 3:C', LatLng(28.703460759990705, -106.14021353423594), 1, 2),
      const Place('Baños 1:E', LatLng(28.703858233086883, -106.13857674669698), 3, 0),
      const Place('Baños 2:E', LatLng(28.703587294174856, -106.13985893896346), 3, 0),
      const Place('Biblioteca', LatLng(28.70308816447431, -106.13823037594557), 4, 0),
      const Place('Cafetería', LatLng(28.7042227092798, -106.13800305873156), 4, 0),
      const Place('Clubes Estudiantiles', LatLng(28.70353310277064, -106.14058770239353), 1, 3),
      const Place('Edificio A - Cubiculos de Maestros', LatLng(28.702639107183625, -106.13968346267939), 4, 0),
      const Place('Enfermeria', LatLng(28.70335224572705, -106.140332557261), 1, 2),
      const Place('Gimnasio', LatLng(28.70306287380711, -106.14051695913075), 1, 2),
      const Place('Impresiones', LatLng(28.703133746475338, -106.14050086587667), 1, 2),
      const Place('Laboratorio de Automática', LatLng(28.703101103883068, -106.14070437848568), 1, 3),
      const Place('Laboratorio de Electrónica', LatLng(28.703498989921297, -106.14033523947), 1, 3),
      const Place('Laboratorio de Física', LatLng(28.703191679699568, -106.14077344536781), 1, 3),
      const Place('Laboratorio de Fotogrametría', LatLng(28.70322990972845, -106.14082708954811), 1, 1),
      const Place('Laboratorio de Geofísica', LatLng(28.703188738927537, -106.14077780395746), 1, 0),
      const Place('Laboratorio de Geología', LatLng(28.703132276088496, -106.14071108400822), 1, 1),
      const Place('Laboratorio de Hidráulica', LatLng(28.703553099953, -106.14038754254578), 1, 1),
      const Place('Laboratorio Isotópico', LatLng(28.703551923648263, -106.14054512232543), 1, 3),
      const Place('Laboratorio de Matemáticas y Sistemas Dinámicos', LatLng(28.70366573107058, -106.14044319838285), 1, 3),
      const Place('Laboratorio de Materiales', LatLng(28.70358015495838, -106.14050254225731), 1, 0),
      const Place('Laboratorio de Metalurgia', LatLng(28.703188738927537, -106.14077780395746), 1, 0),
      const Place('Laboratorio de Mineralogía', LatLng(28.703220205184003, -106.14086128771305), 1, 0),
      const Place('Laboratorio de Química', LatLng(28.703229615651363, -106.14085022360086), 1, 3),
      const Place('Laboratorio de Redes', LatLng(28.703503695142544, -106.14046365022661), 1, 3),
      const Place('Laboratorio de Sanitaria', LatLng(28.703571920827038, -106.14051662385464), 1, 1),
      const Place('Laboratorio de Sensores', LatLng(28.703182269228773, -106.14050522446632), 1, 4),
      const Place('Laboratorio de Simulación y Aleado Mecánico', LatLng(28.703503695142544, -106.14056020975113), 1, 3),
      const Place('Laboratorio de Topografía', LatLng(28.703220205184003, -106.14053539931773), 1, 0),
      const Place('LC', LatLng(28.70326549305051, -106.13991882652044), 0, 0),
      const Place('LC4', LatLng(28.703602798816167, -106.14039257168768), 1, 3),
      const Place('LC5', LatLng(28.703132570165863, -106.14074192941187), 1, 3),
      const Place('LC6', LatLng(28.703204325018383, -106.14068023860455), 1, 3),
      const Place('LC7', LatLng(28.70339518092342, -106.14025712013246), 1, 4),
      const Place('LC9', LatLng(28.703100515728153, -106.14009417593479), 0, 0),
      const Place('LC10',  LatLng(28.703159331202677, -106.14003919064999), 0, 0),
      const Place('LC11', LatLng(28.703207853944285, -106.13998152315617), 0, 0),
      const Place('LC12', LatLng(28.703271080513176, -106.14036206156015), 1, 2),
      const Place('LC13', LatLng(28.703414884055565, -106.14027924835682), 1, 2),
      const Place('Patio de pruebas', LatLng(28.703383711934332, -106.14062726497652), 1, 0),
      const Place('S1', LatLng(28.70292936250924, -106.14022560417652), 0, 0),
      const Place('S2', LatLng(28.70286466534326, -106.14026516675949), 0, 0),
      const Place('S3', LatLng(28.702799085902402, -106.14031679928303), 0, 0),
      const Place('S4', LatLng(28.702727918929003, -106.14036709070206), 0, 0),
      const Place('S5', LatLng(28.702727918929003, -106.14036709070206), 0, 2),
      const Place('S6', LatLng(28.702799085902402, -106.14031679928303), 0, 2),
      const Place('S7', LatLng(28.70286466534326, -106.14026516675949), 0, 2),
      const Place('S8', LatLng(28.70292936250924, -106.14022560417652), 0, 2),
      const Place('S9', LatLng(28.703100515728153, -106.14009417593479), 0, 2),
      const Place('S10',  LatLng(28.703159331202677, -106.14003919064999), 0, 2),
      const Place('S11', LatLng(28.703207853944285, -106.13998152315617), 0, 2),
      const Place('S12', LatLng(28.70326549305051, -106.13991882652044), 0, 2),
    ];
  }

  void reloadBuildingFloor(BuildingModel building, FloorModel floor) {
    final MapsImage image = floor.mapsImage;
    widget.homeController
        .replaceImageOnMap(idRender: building.idOfMapRender, image: image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:Radius.circular(30), topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        title: const Text("UACh Map",style: TextStyle(color: Colors.white,)),
        /*actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.ARCORE);
              },
              child: const Icon(Icons.photo_camera_back_outlined),
            ),
          ],*/
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(78),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity:  _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  focusColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight:Radius.circular(50), topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  ),
                  onTap: () async {
                    final selectedPlace = await showSearch(
                      context: context,
                      delegate: SearchPlacesDelegate(places),
                    );
                    if (selectedPlace != null) {
                      widget.homeController.onTap(selectedPlace.position,false);
                      debugPrint(
                          "DEV: ${selectedPlace.building} ${selectedPlace.floor}");
                      buildings[selectedPlace.building]
                          .setFloorToRender(selectedPlace.floor);
                      text1 = selectedPlace.name;
                    }else{
                      text1 = 'Punto de partida';
                    }
                  },
                  title: Text(
                    text1,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                focusColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight:Radius.circular(50), topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                ),
                onTap: () async {
                  final selectedPlace = await showSearch(
                    context: context,
                    delegate: SearchPlacesDelegate(places),
                  );
                  if (selectedPlace != null) {
                    widget.homeController.onTap(selectedPlace.position,true);
                    debugPrint(
                        "DEV: ${selectedPlace.building} ${selectedPlace.floor}");
                    buildings[selectedPlace.building]
                        .setFloorToRender(selectedPlace.floor);
                    text2 = selectedPlace.name;
                  }else{
                    text2 = 'Punto de llegada';
                  }
                },
                title: Text(
                  text2,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
      body: GoogleMap(
        markers: widget.homeController.markers,
        mapType: MapType.normal,
        initialCameraPosition: widget.homeController.initialCameraPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: widget.homeController.onMapCreated,
        groundOverlays: widget.homeController.classroomsGroundOverlaysSet,
        polylines: widget.homeController.currentRoute,
        zoomControlsEnabled: false,
      ),
      floatingActionButton: ContainerMapOptions(
        homeController: widget.homeController,
        onRouteDisplay: () =>
            handleRouteDisplay(context, widget.homeController),
        onOverlayDisplayCallback: () => showOverlay(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  myPosition() async {
    isLocationServiceEnabled = await Geolocator
        .isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
    return isLocationServiceEnabled;
  }

  handleRouteDisplay(context, controller) {
    controller.loadProgress();
    controller.rutaView(flag);
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
              buildings: buildings,
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