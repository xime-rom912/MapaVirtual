import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapavirtual/home_contoller.dart';
import 'package:mapavirtual/place.dart';

class SearchPlacesDelegate extends SearchDelegate<Place> {
  final List<Place> places;
  List<Place> _filter=[];

  SearchPlacesDelegate(this.places);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(
        onPressed: (){
          query = "";
        },
        icon: const Icon(Icons.close),
    ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, const Place("", LatLng(0, 0)));
        },
        icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if(query != null && places.contains(query.toLowerCase())){
      return ListTile(
        title: Text(query),
        onTap: (){},
      );
    }else{
      return ListTile(
        title: Text("No se encontraron resultados"),
        onTap: () {},
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = places.where((place) {
      return place.name.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (_,index) {
          return ListTile(
            title: Text(_filter[index].name),
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: (){
              final HomeController _controller = HomeController();
              _controller.onTap(MarkerId(_filter[index].name),_filter[index].position);
              close(context, Place(_filter[index].name, _filter[index].position));
            },
          );
        },
    );
  }
}
