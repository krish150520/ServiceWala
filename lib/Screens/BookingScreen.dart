import 'package:flutter/material.dart';
import 'package:servicewala/Theme/AppColors.dart';

class Bookingscreen extends StatefulWidget {
  const Bookingscreen({super.key});

  @override
  State<Bookingscreen> createState() => _BookingscreenState();
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

            Text("Service",style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),)  



          ],
        ),
      ),
    );
  }
}
