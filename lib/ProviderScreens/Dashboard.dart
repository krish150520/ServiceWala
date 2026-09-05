import 'package:flutter/material.dart';
import 'package:servicewala/Theme/AppColors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class DashboardStat {
  final String title;
  final String value;
  final IconData icon;

  DashboardStat({required this.title, required this.value, required this.icon});
}

class _DashboardState extends State<Dashboard> {
  bool isEnabled = false;

  final List<DashboardStat> stats = [
    DashboardStat(
      title: "Total Week Jobs",
      value: "5",
      icon: Icons.business_center,
    ),
    DashboardStat(title: "Total Jobs", value: "125", icon: Icons.ac_unit_sharp),
    DashboardStat(title: "Ratings", value: "4.5", icon: Icons.star),
    DashboardStat(
      title: "Pending Requests",
      value: "4",
      icon: Icons.lock_clock,
    ),
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
              children: [
                _columedText(
                  "Hello, Amit",
                  "Your Dashboard",
                  headingSize: 24,
                  secSize: 14,
                  fWeight: 900,
                ),
                const Spacer(),
                Icon(Icons.notifications),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(211, 38, 207, 125),
                ),
                color: const Color.fromARGB(118, 45, 243, 147),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                spacing: 12,
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    Icons.circle,
                    color: const Color.fromARGB(211, 38, 207, 125),
                    size: 15,
                  ),
                  Text(
                    "You Are Available",
                    style: TextStyle(
                      color: const Color.fromARGB(210, 26, 131, 80),
                      fontSize: 18,
                      fontWeight: FontWeight(600),
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    value: isEnabled,
                    onChanged: (value) {
                      setState(() {
                        isEnabled = !isEnabled;
                      });
                    },
                  ),
                ],
              ),
            ),
            GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      Icon(stats[index].icon),
                      // const Spacer(),
                      _columedText(
                        stats[index].title,
                        stats[index].value,
                        headingSize: 13,
                        secSize: 24,
                        pColor: Colors.black,
                        hColor: const Color.fromARGB(255, 150, 150, 150),
                        isCenter: true,
                        pWeight: 700,
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            Row(
              spacing: 10,
              children: [
                Text(
                  "New Requests",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight(700)),
                ),
                Container(
                  width: 25,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "2",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight(600),
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                Text("View all"),
              ],
            ),

            GridView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      Row(
                        spacing: 5,
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
                          _columedText(
                            "Rohan Mukesh",
                            "Fan Change karna ha",
                            headingSize: 15,
                            secSize: 12,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_rounded),
                          Text("Today, 2:00 PM - 3:30 PM"),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_pin),
                          Text("Ranjit Avenue, Asr"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => print("clicked"),
                            child: Text("Reject"),
                          ),
                          ElevatedButton(
                            onPressed: () => print("clicked"),
                            child: Text("Reject"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _columedText(
  String t1,
  String t2, {
  double headingSize = 17,
  double secSize = 1,
  int fWeight = 600,
  Color hColor = Colors.black,
  Color pColor = const Color.fromARGB(255, 150, 150, 150),
  bool isCenter = false,
  int pWeight = 400,
}) {
  return Column(
    crossAxisAlignment: isCenter == false
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        t1,
        style: TextStyle(
          fontWeight: FontWeight(fWeight),
          fontSize: headingSize,
          color: hColor,
        ),
      ),
      Text(
        t2,
        style: TextStyle(
          fontSize: secSize,
          color: pColor,
          fontWeight: FontWeight(pWeight),
        ),
      ),
    ],
  );
}
