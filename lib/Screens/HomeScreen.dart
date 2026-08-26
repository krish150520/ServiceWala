import "package:flutter/material.dart";
import '../Theme/AppColors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  String selectedValue = "Amritsar";

  final cities = [
    "Amritsar",
    "Jalandhar",
    "Ludhiana",
    "Chandigarh",
    "Delhi",
    "Patiala",
    "Bathinda",
    "Pathankot",
    "Chandigarh",
    "Delhi",
    "Patiala",
    "Bathinda",
    "Pathankot",
    "Chandigarh",
    "Delhi",
    "Patiala",
    "Bathinda",
    "Pathankot",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 55, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------Top_LocationBar--------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.map_outlined),
                    Container(
                      child: TextButton(
                        onPressed: () => {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                constraints: const BoxConstraints(
                                  minWidth: 500,
                                  maxWidth: 520,
                                ),
                                title: const Text("Select Your City"),
                                content: Column(
                                  children: [
                                    SearchBar(
                                      hintText: "Search City",
                                      elevation: WidgetStateProperty.all(0),
                                      constraints: const BoxConstraints(
                                        maxWidth: double.infinity,
                                        maxHeight: 200,
                                        minHeight: 40,
                                      ),
                                      backgroundColor:
                                          const WidgetStatePropertyAll(
                                            Colors.white,
                                          ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () => print("yo"),
                                        child: Text("Use Current Location"),
                                      ),
                                    ),

                                    SizedBox(
                                      width: double.infinity,
                                      height: 550,
                                      child: ScrollConfiguration(
                                        behavior: ScrollConfiguration.of(
                                          context,
                                        ).copyWith(overscroll: false),
                                        child: ListView.builder(
                                          itemCount: cities.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                ListTile(
                                                  title: Text(cities[index]),
                                                  onTap: () => {
                                                    setState(() {
                                                      selectedValue =
                                                          cities[index];
                                                    }),
                                                    Navigator.pop(context),
                                                  },
                                                ),
                                                const Divider(
                                                  height: 1,
                                                  thickness: 1,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        },
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text(selectedValue + " ,Punjab"),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.notifications),
              ],
            ),

            //--------Starter--------
            Text(
              "Hello, Krish",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),

            Text(
              "What Service would you like today?",
              style: TextStyle(color: Colors.black45),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),

              child: SearchBar(
                leading: const Icon(Icons.search),
                hintText: "Search For Services",
                elevation: WidgetStatePropertyAll(0),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                side: const WidgetStatePropertyAll(
                  BorderSide(color: Colors.black12, width: 1),
                ),
              ),
            ),

            //---------Banner---------
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 44, 41, 196),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(width: double.infinity, height: 150),
            ),
            Padding(padding: EdgeInsets.only(top: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Our Services",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
