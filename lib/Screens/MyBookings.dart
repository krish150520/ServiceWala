import 'package:flutter/material.dart';
import 'package:servicewala/Theme/AppColors.dart';

class Mybookings extends StatefulWidget {
  const Mybookings({super.key});

  @override
  State<Mybookings> createState() => _MybookingsState();
}

class AgentDetails{
  final String name;
  final String status;
  final String service;


  AgentDetails({
    required this.name,
    required this.status,
    required this.service,
  
  });
  
}
class _MybookingsState extends State<Mybookings> {


  final List<AgentDetails>bookings = [
    AgentDetails(name: "Ramesh", status: "Ongoing", service: "Electricion"),
    AgentDetails(name: "Niharika", status: "Completed", service: "Plumber"),
    AgentDetails(name: "CSK", status: "Completed", service: "Carpanter"),
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
                itemCount: bookings.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 23,
                              padding: EdgeInsets.all(2),
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: bookings[index].status == "Completed" ?  Color.fromARGB(255, 104, 255, 162) : Color.fromARGB(255, 177, 157, 229),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                              ),
                              child: Text(
                                bookings[index].status,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          
                              Text("Booking Id: #341037 "),
                          ],
                        ),
                        Container(
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
                                      bookings[index].name,
                                      style: TextStyle(
                                        fontWeight: FontWeight(700),
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(bookings[index].status),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Icon(Icons.calendar_view_week),
                                          Text("24th May 2025, 11:45 AM"),
                                        ],
                                      ),

                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Icon(Icons.location_pin),
                                          Text(
                                            "Home | Ranjit Avenue, Amritsar",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  OutlinedButton(
                                    onPressed: () => print("yo"),
                                    child: Text("call"),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
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
