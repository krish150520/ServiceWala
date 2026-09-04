import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
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