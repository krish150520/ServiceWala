import "package:flutter/material.dart";
import '../Theme/AppColors.dart';
import '../widgets/Footer.dart';
import 'SearchScreen.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 55,
          left: 25,
          right: 25,
          bottom: 30,
        ),
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

                    TextButton(
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

            const SizedBox(height: 20),
            //-------------Services-Cards------------
            GridView.builder(
              itemCount: 6,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 1.2,
                    ),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Icon(Icons.bolt_sharp, color: Colors.red),
                      ),

                      Text(
                        "Plumber",
                        style: TextStyle(
                          fontWeight: FontWeight(600),
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            //------------Top-Rated-Nearby--------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Rated Nearby",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/spidey.jpg',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            "Ramesh Kummar",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.verified, color: AppColors.primary),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
