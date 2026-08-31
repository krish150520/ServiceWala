import 'package:flutter/material.dart';
import 'package:servicewala/Theme/AppColors.dart';

class Bookingscreen extends StatefulWidget {
  const Bookingscreen({super.key});

  @override
  State<Bookingscreen> createState() => _BookingscreenState();
}

class StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Text(label, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ],
    );
  }
}

class _BookingscreenState extends State<Bookingscreen> {
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
            //-----------Header-----------
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 1,
                        color: AppColors.borderColor,
                      ),
                    ),
                    child: Icon(Icons.keyboard_arrow_left),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Book Service",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            //----------------Card--------------
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                spacing: 15,
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
                  Expanded(
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rakesh Kumar",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Election Services",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.amber,
                                ),
                                Text("| 54 Reviews"),
                                Text("| 2.3Km Away"),
                              ],
                            ),
                          ],
                        ),
                        Icon(Icons.call, color: Colors.green),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //----------Buttons---------
            Row(
              spacing: 16,
              children: [
                //----------CALL-----------
                SizedBox(
                  width: 109,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => print("fdg"),
                    child: Text("Call", style: TextStyle(color: Colors.green)),
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        const Color.fromARGB(41, 76, 175, 79),
                      ),
                      elevation: WidgetStatePropertyAll(0),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      side: const WidgetStatePropertyAll(
                        BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 109,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => print("fdg"),
                    child: Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll(0),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.primary,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 109,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => print("fdg"),
                    child: Text(
                      "Call",
                      style: TextStyle(color: AppColors.primary),
                    ),
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll(0),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      side: const WidgetStatePropertyAll(
                        BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "About the Provider",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            //-------------About----------------
            Container(
              width: double.infinity,
              height: 150,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(95, 131, 195, 255),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 2,
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          size: 50,
                          color: Colors.blue,
                        ),
                        Text(
                          "Verified Professinal",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight(700)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      spacing: 19,
                      children: [
                        Text(
                          "Experienced electrician with 5+ years of experience serving customers in Amritsar.",
                        ),

                        Row(
                          spacing: 10,
                          children: [
                            StatItem(
                              icon: Icons.workspace_premium,
                              value: "5+",
                              label: "Years Experience",
                            ),
                            StatItem(
                              icon: Icons.task,
                              value: "120+",
                              label: "Jobs Compled",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Preferred Date & Time",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),
            //------------------Date&Time Selection-----------
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        initialDate: DateTime.now(),
                      );

                      if (selectedDate != null) {
                        print(selectedDate);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 175,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: AppColors.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(75, 122, 195, 255),
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Select Date',
                                style: TextStyle(fontWeight: FontWeight(600)),
                              ),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 175,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: AppColors.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Select Time',
                                style: TextStyle(fontWeight: FontWeight(600)),
                              ),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Service Address",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Flat 402,Golden Crest,",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 102, 102, 102),
                        ),
                      ),
                      Text(
                        "Amritsar,Punjab",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 102, 102, 102),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Text("Change", style: TextStyle(color: AppColors.primary)),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Text(
                  "Reviews",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(" (54)"),
                const Spacer(),
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

            const SizedBox(height: 5),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 160,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text(
                          "4.8 ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 2,
                          children: [
                            Icon(Icons.star, color: const Color.fromARGB(255, 255, 186, 59)),
                            Icon(Icons.star, color: const Color.fromARGB(255, 255, 186, 59)),
                            Icon(Icons.star, color: const Color.fromARGB(255, 255, 186, 59)),
                            Icon(Icons.star, color: const Color.fromARGB(255, 255, 186, 59)),
                            Icon(Icons.star, color: const Color.fromARGB(255, 255, 186, 59)),
                          ],
                        ),
                        Text(
                          "Based on 54 reviews",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 180,
                    height: 100,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'assets/images/spidey.jpg',
                                height: 25,
                                width: 25,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                "AmanPreet Singh",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                          child: Text(
                            "Very Good and nice polite service",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
