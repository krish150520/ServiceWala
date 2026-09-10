import 'package:flutter/material.dart';
import './Screens/MainScreen.dart';
import 'Screens/auth/splash_screen.dart';
void main(){
  runApp(const ServiceWala());
}

class ServiceWala extends StatelessWidget{
  const ServiceWala({super.key});
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: "servicewalah",
         home:MainScreen(),
         debugShowCheckedModeBanner: false,
       
        
      );
  }
}