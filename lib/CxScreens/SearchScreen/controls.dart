import "package:flutter/material.dart";

class Controls extends StatelessWidget {
  const Controls({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      
      child:Stack (
        fit: StackFit.expand,
        children:[ Positioned(
         top: 10,
         left: 10,
         right: 10,
          child: SearchAnchor(
            builder: (context, controller) {
              return SearchBar(
                onTap: () {
                  controller.openView();
                },
                controller:controller,                // hintText: "hey search agents here",
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
         // Temporary button to test bottom sheet
         
       Positioned(
        right: 20,
        bottom: 20,
        child: FloatingActionButton(onPressed: ()=> print("fetching location of user"),
       shape: CircleBorder(),
       child: Icon(Icons.my_location),
       
       )
       )
        ],
      ),
      
    );
  }
}
