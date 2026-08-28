import "package:flutter/material.dart";

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
class MapHolder extends StatelessWidget {
  const MapHolder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/spidey.jpg',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

// all things releated to controls and buttons which will hover over map will be here
class Controls extends StatelessWidget {
  const Controls({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: SearchAnchor(
            builder: (context, controller) {
              return SearchBar(
                onTap: () {
                  controller.openView();
                },
                controller: controller,
                // hintText: "hey search agents here",
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (context, controller) {
              final query = controller.text.toLowerCase();
              final agents = ["rakesh", "rajesh", "dhamesh"];
              final results = agents
                  .where((name) => name.toLowerCase().contains(query))
                  .toList();
              return results
                  .map((name) => ListTile(title: Text(name)))
                  .toList();
            },
          ),
        ),
      ),
    );
  }
}
