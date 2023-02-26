import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/Controllers/home_contoller.dart';

class AccordionLayers extends StatefulWidget {
  const AccordionLayers({required this.homeController, super.key});
  final HomeController homeController;

  @override
  _AccordionLayersState createState() => _AccordionLayersState();
}

class _AccordionLayersState extends State<AccordionLayers> {
  final List<Item> _items = <Item>[
    Item(
      headerValue: 'Item 1',
      expandedValue: 'Contenido del Item 1',
    ),
    Item(
      headerValue: 'Item 2',
      expandedValue: 'Contenido del Item 2',
    ),
    Item(
      headerValue: 'Item 3',
      expandedValue: 'Contenido del Item 3',
    ),
    Item(
      headerValue: 'Item 4',
      expandedValue: 'Contenido del Item 4',
    ),
    Item(
      headerValue: 'Item 5',
      expandedValue: 'Contenido del Item 5',
    ),
    Item(
      headerValue: 'Item 6',
      expandedValue: 'Contenido del Item 6',
    ),
    Item(
      headerValue: 'Item 7',
      expandedValue: 'Contenido del Item 7',
    ),
    Item(
      headerValue: 'Item 8',
      expandedValue: 'Contenido del Item 8',
    ),
    Item(
      headerValue: 'Item 9',
      expandedValue: 'Contenido del Item 9',
    ),
    Item(
      headerValue: 'Item 10',
      expandedValue: 'Contenido del Item 10',
    ),
  ];
  late List<BuildingModel> buildings;

  @override
  void initState() {
    super.initState();
    buildings = <BuildingModel>[
      BuildingModel(
        name: "Laboratorios",
        floors: <FloorModel>[
          const FloorModel(
            name: "Subnivel 2",
            mapsImage: MapsImage(
              ID: "SL2",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_s2_03.png",
              size: Size(110, 110),
            ),
          ),
          const FloorModel(
            name: "Subnivel 1",
            mapsImage: MapsImage(
              ID: "SL1",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_s1_03.png",
              size: Size(110, 110),
            ),
          ),
          const FloorModel(
            name: "Nivel 0",
            mapsImage: MapsImage(
              ID: "L0",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_0_03.png",
              size: Size(110, 110),
            ),
          ),
          const FloorModel(
            name: "Nivel 1",
            mapsImage: MapsImage(
              ID: "L1",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_1_03.png",
              size: Size(110, 110),
            ),
          ),
          const FloorModel(
            name: "Nivel 2",
            mapsImage: MapsImage(
              ID: "L2",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_2_03.png",
              size: Size(110, 110),
            ),
          ),
        ],
        onChangeBuildingFloor: (BuildingModel building, FloorModel floor) {
          final MapsImage image = floor.mapsImage;
          widget.homeController.loadImageOnMap(
            imageFilename: image.filename,
            coords: image.coords,
            id: image.ID,
            imageSize: image.size,
          );
        },
      ),
      BuildingModel(
        name: "Laboratorios",
        floors: <FloorModel>[
          const FloorModel(
            name: "Subnivel 2",
            mapsImage: MapsImage(
              ID: "SL2",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_s2_03.png",
              size: Size(110, 110),
            ),
          ),
          const FloorModel(
            name: "Subnivel 1",
            mapsImage: MapsImage(
              ID: "SL1",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_s1_03.png",
              size: Size(110, 110),
            ),
          ),
          const FloorModel(
            name: "Nivel 0",
            mapsImage: MapsImage(
              ID: "L0",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_0_03.png",
              size: Size(110, 110),
            ),
          ),
          const FloorModel(
            name: "Nivel 1",
            mapsImage: MapsImage(
              ID: "L1",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_1_03.png",
              size: Size(110, 110),
            ),
          ),
          const FloorModel(
            name: "Nivel 2",
            mapsImage: MapsImage(
              ID: "L2",
              coords: LatLng(28.703168888427548, -106.14043582907642),
              filename: "assets/png/laboratories_level_2_03.png",
              size: Size(110, 110),
            ),
          ),
        ],
        onChangeBuildingFloor: (BuildingModel building, FloorModel floor) {
          final MapsImage image = floor.mapsImage;
          widget.homeController.loadImageOnMap(
            imageFilename: image.filename,
            coords: image.coords,
            id: image.ID,
            imageSize: image.size,
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          debugPrint("Building $index Clicked");
          debugPrint("${buildings[index].isExpanded}");
          setState(() {
            // buildings[index].isExpanded = !buildings[index].isExpanded;
            buildings[index].toogleExpanded();
          });
          debugPrint("${buildings[index].isExpanded}");
        },
        children: buildings.map((BuildingModel building) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(building.name),
              );
            },
            body: Column(
              children: building.floors.map((FloorModel floor) {
                return RadioListTile(
                  title: Text(floor.name),
                  value: 1,
                  groupValue: building.floorToRender,
                  onChanged: (value) {
                    // setState(() {
                    //   building.floorToRender = value as int;
                    // });
                    building.setFloorToRender(value as int);
                  },
                );
              }).toList(),
            ),
            // body: const Text("A"),
            isExpanded: building.isExpanded,
            canTapOnHeader: true,
          );
        }).toList(),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

typedef OnChangeBuildingFloorCallback = Function(BuildingModel, FloorModel);

class BuildingModel {
  BuildingModel({
    required this.name,
    required this.floors,
    required this.onChangeBuildingFloor,
    this.floorToRender = 2,
    this.isExpanded = false,
  });

  void setFloorToRender(int floorToRender) {
    if (floorToRender > 0 && floorToRender < floors.length) {
      this.floorToRender = floorToRender;
      onChangeBuildingFloor(this, floors[floorToRender]);
    } else {
      // TODO: Add necesary exceptions to the code
    }
  }

  void toogleExpanded() {
    isExpanded = !isExpanded;
  }

  int floorToRender;
  bool isExpanded;
  final String name;
  final List<FloorModel> floors;
  final OnChangeBuildingFloorCallback onChangeBuildingFloor;
}

class FloorModel {
  const FloorModel({
    required this.name,
    required this.mapsImage,
  });

  final String name;
  final MapsImage mapsImage;
}

class MapsImage {
  const MapsImage({
    required this.ID,
    required this.filename,
    required this.coords,
    required this.size,
  });
  final String ID;
  final String filename;
  final LatLng coords;
  final Size size;
}
