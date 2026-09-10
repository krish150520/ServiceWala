import 'package:flutter/material.dart';
import 'package:servicewala/Screens/BookingScreen.dart';
import '../widgets/Footer.dart';
import 'HomeScreen.dart';
import 'SearchScreen/SearchScreen.dart';
import 'MyBookings.dart';
import 'auth/loginscreen.dart';
import 'auth/splash_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // int _currentIndex = 0;

  // final List<Widget> _screens = const [Homescreen(), SearchScreen(),Mybookings()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  title: 'servicewala',
  debugShowCheckedModeBanner: false,
  home: ServiceWalaSplashScreen(
    isAuthenticated: false,
    onNavigateToHome: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    },
    onNavigateToLogin: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeBackScreen()),
      );
    },
  ),
);
    
    
    
    
    
    
    
    // Scaffold(
    //   body: _screens[_currentIndex],
    
    //   bottomNavigationBar: BottomNavigationFooter(
        
    //     currentIndex: _currentIndex,
    //     onTap: (index) {
    //       setState(() {
    //         _currentIndex = index;
    //       });
    //     },
    //   ),
    // );
  }
}
