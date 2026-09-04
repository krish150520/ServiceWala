import 'package:flutter/material.dart';
import 'package:servicewala/Theme/AppColors.dart';

class BookingStatus extends StatefulWidget {
  const BookingStatus({super.key});

  @override
  State<BookingStatus> createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 55,
          left: 25,
          right: 25,
          bottom: 30,
        ),
        width: double.infinity,
        height: double.infinity,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.keyboard_arrow_left),
                Text(
                  "Booking Status",
                  style: TextStyle(fontWeight: FontWeight(700), fontSize: 24),
                ),
                SizedBox(
                  width: 55,
                  child: Row(
                    children: [Icon(Icons.headset_mic_rounded), Text("Help")],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            //-----------------Confirmed Booking Container-----------------
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 15,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(137, 198, 248, 200),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 79, 211, 53),
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Icon(
                        Icons.check,
                        weight: 800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booking Confirmed",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 79, 211, 53),
                          fontWeight: FontWeight(700),
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: Text(
                          "Your Service is Confirmed.The provider is on the way",
                          maxLines: 2,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 151, 151, 151),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            //----------------BookingId & Date--------------

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Booking ID",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 126, 126, 126),
                      ),
                    ),
                    Text(
                      "#583VBF823",
                      style: TextStyle(fontWeight: FontWeight(600)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Placed On",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 126, 126, 126),
                      ),
                    ),
                    Text(
                      "27th May ,2026",
                      style: TextStyle(fontWeight: FontWeight(600)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

              //----------------Live Updates---------------
            
            Text("Live Updates"),
            const SizedBox(height: 20),

            Row(
              spacing: 10,
              children: [
                Column(
                  children: [
                    _stepIcon(Icons.check, true),
                    _line(true),
                    _stepIcon(Icons.check, true),
                    _line(true),
                    _stepIcon(Icons.pedal_bike, true),
                    _line(false),
                    _stepIcon(Icons.check, false),
                  ],
                ),
                Column(
                  spacing: 23,
                  children: [
                    _columedText(
                      "Booking Confirmed",
                      "24th May 2026, 10:36 AM",
                    ),
                    _columedText("Provider Assigned", "25th May 2026, 7:36 PM"),
                    _columedText(
                      "Provider on the way",
                      "25th May 2026, 10:36 PM",
                    ),
                    _columedText("Service Completed", "Pending"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            //----------Your Provider Card-----------------
            Text("Your Provider"),
            const SizedBox(height: 10),

            Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 12,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ravi Kumar"),
                      Text("Electricon"),
                      Text("4.8* | 4.5yr exp."),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      OutlinedButton(
                        onPressed: () => print("HJ"),
                        child: Text("Call"),
                      ),
                      OutlinedButton(
                        onPressed: () => print("HJ"),
                        child: Text("Chat"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            //-----------Booking Details--------------
            Text("Your Provider"),
            const SizedBox(height: 10),

            Container(
              height: 80,
              padding: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
          
                spacing: 12,
                children: [
                  Icon(Icons.location_pin),
                  _columedText("Location", "Home | Ranjit Avenue",headingSize: 14,secSize: 11),
                  const Spacer(),
                   Icon(Icons.calendar_view_week),
                  _columedText("Date & Time","24th May 2026, 7PM",headingSize: 14,secSize: 11),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _stepIcon(IconData icon, bool active) {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: active ? Colors.green : Colors.grey.shade100,
      border: active ? null : Border.all(color: Colors.grey.shade300),
    ),
    child: Icon(
      icon,
      color: active ? Colors.white : Colors.grey.shade600,
      size: 20,
    ),
  );
}

Widget _line(bool active) {
  return Container(
    width: 2,
    height: 25,
    margin: EdgeInsets.only(top: 5, bottom: 5),
    color: active ? Colors.green : Colors.grey.shade300,
  );
}

Widget _columedText(String t1, String t2,{double headingSize = 17 , double secSize = 1}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(t1, style: TextStyle(fontWeight: FontWeight(600), fontSize: headingSize)),
      Text(
        t2,
        style: TextStyle(
          fontSize: secSize,
          color: const Color.fromARGB(255, 150, 150, 150),
        ),
      ),
    ],
  );
}
