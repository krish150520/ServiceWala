import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: SearchBar(
              onSubmitted: (value) => print(value),
              hintText: "kuch likh la we",
              leading: Icon(Icons.search),
            ),
          ),
         Container(
            margin: EdgeInsets.only(top: 50),
            color: Colors.blue,
            height: 100,
            width: 200,
            child:Container(
              color: Colors.black,
              width: 10,
              height: 10,
              margin: EdgeInsets.only(left: ),
            )
          )
        ],
      ),
    );
  }
}
