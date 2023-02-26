import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/Controllers/home_contoller.dart';
import 'package:mapavirtual/floor_item.dart';

class AccordionLayers extends StatefulWidget {
  const AccordionLayers(
      {required this.buildings, required this.homeController, super.key});
  final HomeController homeController;
  final List<BuildingModel> buildings;

  @override
  _AccordionLayersState createState() => _AccordionLayersState();
}

class _AccordionLayersState extends State<AccordionLayers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("FTR ${widget.buildings[0].floorToRender}");
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          debugPrint("Building $index Clicked");
          debugPrint("${widget.buildings[index].isExpanded}");
          setState(() {
            // widget.buildings[index].isExpanded = !widget.buildings[index].isExpanded;
            widget.buildings[index].toogleExpanded();
          });
          debugPrint("${widget.buildings[index].isExpanded}");
        },
        children: widget.buildings.map((BuildingModel building) {
          return buildingItem(building);
        }).toList(),
      ),
    );
  }

  ExpansionPanel buildingItem(BuildingModel building) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text(building.name),
        );
      },
      body: Column(
        children: renderOptions(building),
      ),
      // body: const Text("A"),
      isExpanded: building.isExpanded,
      canTapOnHeader: true,
    );
  }

  List<Widget> renderOptions(BuildingModel building) {
    // debugPrint("FTR ${building.hashCode}");
    int length = building.floors.length;
    List<Widget> optionsList = [];
    for (int i = 0; i < length; i++) {
      optionsList.add(
        floorItem(
          index: i,
          building: building,
          floor: building.floors[i],
        ),
      );
    }
    return optionsList;
  }

  Widget floorItem({
    required int index,
    required BuildingModel building,
    required FloorModel floor,
  }) {
    return RadioListTile(
      key: Key(floor.name),
      title: Text(floor.name),
      value: index,
      groupValue: building.floorToRender,
      onChanged: (value) {
        // debugPrint("FTR ${widget.building.floorToRender}");
        setState(() {
          building.setFloorToRender(value as int);
        });
        // debugPrint("FTR ${widget.building.floorToRender}");
      },
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
    required this.idOfMapRender,
    required this.name,
    required this.floors,
    required this.onChangeBuildingFloor,
    this.floorToRender = 2,
    this.isExpanded = false,
  });

  void setFloorToRender(int floorToRender) {
    debugPrint("PREVIOUS FLOOR TO RENDER ${this.floorToRender}");
    if (floorToRender >= 0 && floorToRender < floors.length) {
      this.floorToRender = floorToRender;
      onChangeBuildingFloor(this, floors[floorToRender]);
    } else {
      debugPrint("ELSE: THE SELECTED FLOOR IS NOT ALLOWED");
      // TODO: Add necesary exceptions to the code
    }
  }

  void toogleExpanded() {
    isExpanded = !isExpanded;
  }

  String idOfMapRender;
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
