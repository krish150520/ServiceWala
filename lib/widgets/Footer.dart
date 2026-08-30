import 'package:flutter/material.dart';

class BottomNavigationFooter extends StatelessWidget{

  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationFooter ({
      super.key,
      required this.currentIndex,
      required this.onTap,
    });
  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed ,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
       
      ],
    );
  }
}