import 'package:flutter/material.dart';

class AccordionLayers extends StatefulWidget {
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
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          debugPrint("ITEM $index Clicked");
          setState(() {
            _items[index].isExpanded = !isExpanded;
          });
        },
        children: _items.map((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.headerValue),
              );
            },
            body: ListTile(
              title: Text(item.expandedValue),
            ),
            isExpanded: item.isExpanded,
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
