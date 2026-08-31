import "package:flutter/material.dart";
import 'MapHolder.dart';
import 'controls.dart';
import 'package:servicewala/Theme/AppColors.dart';

// main screen which will hold both map and its controls
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapHolder(),
          DraggableScrollableSheet(
            initialChildSize: 0.32,
            minChildSize: 0.32,
            maxChildSize: 0.9,

            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),

                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(10),
                  children: [
                    const SizedBox(height: 10),

                    const Text(
                      'Agents nearby',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Your agent widgets
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(child: Text("Rakesh - Plumber")),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(child: Text("Rajesh - Electrician")),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(child: Text("Dhamesh - Carpenter")),
                    ),
                  ],
                ),
              );
            },
          ),
          const Controls(),
        ],
      ),
    );
  }
}

// all changes realted to maps will be maded in this class
