import 'package:flutter/material.dart';
import 'CxScreens/MainScreen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
    url: 'https://ubcckqrrvjhidotoewgl.supabase.co',
    anonKey: 'sb_publishable_gY8t3ZELaBCCb3-zkFkFXA_zWJIIFnB',  //SUPABASE INITALIZATION
  );
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