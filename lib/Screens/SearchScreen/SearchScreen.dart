import 'dart:ffi';

import "package:flutter/material.dart";
import 'MapHolder.dart';
import 'controls.dart';
import 'package:servicewala/Theme/AppColors.dart';

class locationinfo {
  final Int nearbyfound;
  locationinfo({required this.nearbyfound});
}

class Provider {
  final String name;
  final String profession;
  final String experience;
  final String price;
  final String rating;
  final String reviews;
  final String distance;
  final List<String> services;
  final bool available;
  final bool verified;

  Provider({
    required this.name,
    required this.profession,
    required this.experience,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.services,
    this.available = true,
    this.verified = true,
  });
}

final List<Provider> providers = [
  Provider(
    name: "Ramesh Kumar",
    profession: "Senior Electrician",
    experience: "5+ yrs exp",
    price: "₹199",
    rating: "4.9",
    reviews: "142",
    distance: "1.2 km",
    services: ["Wiring", "Appliance Repair"],
  ),

  Provider(
    name: "Priya Sharma",
    profession: "Expert Plumber",
    experience: "8 yrs exp",
    price: "₹249",
    rating: "4.8",
    reviews: "98",
    distance: "0.8 km",
    services: ["Pipe Fitting", "Leak Repair"],
  ),

  Provider(
    name: "Vikram Patel",
    profession: "Master Carpenter",
    experience: "6 yrs exp",
    price: "₹179",
    rating: "4.7",
    reviews: "67",
    distance: "2.1 km",
    services: ["Furniture", "Woodwork"],
  ),

  Provider(
    name: "Anita Desai",
    profession: "AC Technician",
    experience: "4 yrs exp",
    price: "₹299",
    rating: "4.6",
    reviews: "53",
    distance: "3.0 km",
    services: ["AC Service", "Installation"],
  ),
];
//  bool flag=false;

// main screen which will hold both map and its controls
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool flag = false;
  int selectedFilter = -1;
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
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 30,
                        height: 4,

                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Nearby Agents",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: const Text(
                            "12 found",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        const Text(
                          "Sort: ",
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Nearest",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _filterChip(
                            icon: Icons.bolt,
                            text: "Available Now",
                            selected: selectedFilter == 0,
                            onTap: () {
                              setState(() {
                                selectedFilter = 0;
                              });
                            },
                          ),

                          _filterChip(
                            icon: Icons.star,
                            text: "4.5+ Rating",
                            selected: selectedFilter == 1,
                            onTap: () {
                              setState(() {
                                selectedFilter = 1;
                              });
                            },
                          ),

                          _filterChip(
                            icon: Icons.location_on,
                            text: "< 3 km",
                            selected: selectedFilter == 2,
                            onTap: () {
                              setState(() {
                                selectedFilter = 2;
                              });
                            },
                          ),

                          _filterChip(
                            icon: Icons.currency_rupee,
                            text: "Budget Friendly",
                            selected: selectedFilter == 3,
                            onTap: () {
                              setState(() {
                                selectedFilter = 3;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // -------------------------
                    // PROVIDER CARDS
                    // -------------------------
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: providers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _providerCard(providers[index]),
                        );
                      },
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

Widget _filterChip({
  required IconData icon,
  required String text,
  bool selected = false,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,

    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: selected ? Colors.white : Colors.amber),

          const SizedBox(width: 5),

          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _providerCard(Provider provider) {
  return Container(
    padding: const EdgeInsets.all(10),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.borderColor, width: 1),
    ),

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        // Profile  image
      
        Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade200,

                  child: Icon(
                    Icons.person,
                    size: 32,
                    color: Colors.grey.shade500,
                  ),
                ),

                if (provider.available)
                  Positioned(
                    right: 1,
                    bottom: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 6),

            // verified icon
            if (provider.verified)
              Icon(Icons.verified, size: 15, color: AppColors.primary),
          ],
        ),

        const SizedBox(width: 10),

      
        // Middle information
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NAME + VERIFIED
              Row(
                children: [
                  Flexible(
                    child: Text(
                      provider.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 4),

                  if (provider.verified)
                    Icon(Icons.verified, size: 14, color: AppColors.primary),
                ],
              ),

              const SizedBox(height: 3),

              // PROFESSION + EXPERIENCE
              Text(
                "${provider.profession} • ${provider.experience}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 6),

              // RATING + DISTANCE
              Row(
                children: [
                  const Icon(Icons.star, size: 15, color: Colors.amber),

                  const SizedBox(width: 3),

                  Text(
                    provider.rating,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 3),

                  Text(
                    "(${provider.reviews})",
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  ),

                  const SizedBox(width: 8),

                  Icon(
                    Icons.location_on,
                    size: 13,
                    color: Colors.grey.shade500,
                  ),

                  const SizedBox(width: 2),

                  Text(
                    provider.distance,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  ),
                ],
              ),

              const SizedBox(height: 7),

              // SERVICE TAGS
              Wrap(
                spacing: 5,
                runSpacing: 4,
                children: provider.services
                    .map(
                      (service) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          service,
                          style: TextStyle(
                            fontSize: 9,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        //  price+button
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              provider.price,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            Text(
              "onw.",
              style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: 70,
              height: 28,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  provider.name == "Priya Sharma" ||
                          provider.name == "Anita Desai"
                      ? "View"
                      : "Book",
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// all changes realted to maps will be maded in this class
