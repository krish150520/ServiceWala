import "package:flutter/material.dart";
import 'MapHolder.dart';
import 'controls.dart';

// main screen which will hold both map and its controls
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [const MapHolder(), const Controls()]),
    );
  }
}

// all changes realted to maps will be maded in this class
