import 'package:flutter/material.dart';

void main(){
  runApp(const test());
}

class test extends StatelessWidget{
    const test({super.key});
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
        body: Center(
        
          child: OutlinedButton(onPressed: hey, child: Text("press me")),
        ),
    ),
    );
  }
  void hey(){
    print("button is clicked");
  }
}