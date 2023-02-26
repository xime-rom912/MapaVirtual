import 'package:flutter/material.dart';
import 'package:mapavirtual/Controllers/home_contoller.dart';
import 'package:mapavirtual/accordion_layers.dart';

class FloorItem extends StatefulWidget {
  const FloorItem(
      {required this.index,
      required this.building,
      required this.homeController,
      super.key});
  final HomeController homeController;
  final BuildingModel building;
  final int index;

  @override
  State<FloorItem> createState() => _FloorItemState();
}

class _FloorItemState extends State<FloorItem> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      key: Key(widget.building.floors[widget.index].name),
      title: Text(widget.building.floors[widget.index].name),
      value: widget.index,
      groupValue: widget.building.floorToRender,
      onChanged: (value) {
        // debugPrint("FTR ${widget.building.floorToRender}");
        setState(() {
          // widget.building.floorToRender = value as int;
          widget.building.setFloorToRender(value as int);
        });
        // debugPrint("FTR ${widget.building.floorToRender}");
      },
    );
  }
}
