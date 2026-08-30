import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'widget/LocationPointer.dart';
// used flutter map to add real map and latlong for cordinates and zoom
class MapHolder extends StatelessWidget {
  const MapHolder({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(31.6340, 74.8723),
        initialZoom: 13,
      ),
      children: [
        TileLayer(
           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.servicewala',
        ),
        MarkerLayer(
      markers: [
        Marker(
          point: LatLng(31.6340, 74.8723),
          width: 80,
          height: 100,
          child: const UserMarker(
            imagePath: 'assets/images/spidey.jpg',
          ),
        )
      ],
      )
      ],
    );
  }
}

// all things releated to controls and buttons which will hover over map will be here
