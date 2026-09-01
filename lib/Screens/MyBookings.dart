import 'package:flutter/material.dart';
import 'package:servicewala/Theme/AppColors.dart';

class Mybookings extends StatefulWidget {
  const Mybookings({super.key});

  @override
  State<Mybookings> createState() => _MybookingsState();
}

class _MybookingsState extends State<Mybookings> {
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Bookings",
                  style: TextStyle(fontWeight: FontWeight(700), fontSize: 24),
                ),
                Icon(Icons.notifications),
              ],
            ),

            const SizedBox(height: 20),

            DefaultTabController(
              length: 3,
              child: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2),
                ),
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "All"),
                  Tab(text: "Upcoming"),
                  Tab(text: "Completed"),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 700,
              child: ListView.separated(
                itemCount: 5,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 23,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 177, 157, 229),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "UPCOMING",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Column(
                              children: [Text("Booking Id:"), Text("#341037")],
                            ),
                          ],
                        ),
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        'assets/images/spidey.jpg',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Plumber",
                                      style: TextStyle(
                                        fontWeight: FontWeight(700),
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text("Scheduled"),
                                    Icon(Icons.keyboard_arrow_right),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Divider(thickness: 1),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Icon(Icons.calendar_view_week),
                                      Text("24th May 2025, 11:45 AM")
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return (const SizedBox(height: 25));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
