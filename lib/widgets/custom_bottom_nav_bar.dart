
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home.dart';
import 'package:flutter_application/screens/notifications.dart';
import 'package:flutter_application/screens/profile_screen/user_profile.dart';
import 'package:flutter_application/screens/stats/stats.dart';
import 'package:flutter_application/themes/custom_color.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // const UpcomingMissions(),
    const DashboardScreen(),
    const Stats(), const Notifications(), UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF80DEEA),
      body: _pages[_currentIndex], // Display the current page
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: const Color(0xFF80DEEA),
        shadowColor: Colors.yellow,
        showElevation: true,
        selectedIndex: _currentIndex,
        itemCornerRadius: 24,
        iconSize: 20,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        blurRadius: 1,
        itemPadding: EdgeInsets.zero,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: SizedBox(
              width: 24, // Adjust width as needed
              height: 24, // Adjust height as needed
              child: Center(
                child: Image(
                  height: 18,
                  color: _currentIndex == 0 ? Color(0xFF2E3A59) : null,
                  image: const AssetImage("assets/images/home.png"),
                ),
              ),
            ),
            title: _currentIndex == 0
                ? const Center(
                    child: Text(
                      'Home',
                      style:
                          TextStyle(fontSize: 12), // Adjust font size as needed
                    ),
                  )
                : const SizedBox.shrink(),
            activeColor: Color(0xFF2E3A59),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: SizedBox(
              width: 24, // Adjust width as needed
              height: 24, // Adjust height as needed
              child: Center(
                child: Image(
                  height: 18,
                  color: _currentIndex == 1 ? Color(0xFF2E3A59) : null,
                  image: const AssetImage("assets/images/stats.png"),
                ),
              ),
            ),
            title: _currentIndex == 1
                ? const Center(
                    child: Text(
                      'Stats',
                      style:
                          TextStyle(fontSize: 12), // Adjust font size as needed
                    ),
                  )
                : const SizedBox.shrink(),
            activeColor: Color(0xFF2E3A59),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: SizedBox(
              width: 24, // Adjust width as needed
              height: 24, // Adjust height as needed
              child: Center(
                child: Image(
                  height: 20,
                  color: _currentIndex == 2 ? Color(0xFF2E3A59) : null,
                  image: const AssetImage("assets/images/notifications.png"),
                ),
              ),
            ),
            title: _currentIndex == 2
                ? const Center(
                    child: Text(
                      'Notifications',
                      style:
                          TextStyle(fontSize: 12), // Adjust font size as needed
                    ),
                  )
                : const SizedBox.shrink(),
            activeColor: Color(0xFF2E3A59),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: SizedBox(
              width: 24, // Adjust width as needed
              height: 24, // Adjust height as needed
              child: Center(
                child: Image(
                  height: 18,
                  color: _currentIndex == 3 ? Color(0xFF2E3A59) : null,
                  image: const AssetImage("assets/images/user.png"),
                ),
              ),
            ),
            title: _currentIndex == 3
                ? const Center(
                    child: Text(
                      'Profile',
                      style:
                          TextStyle(fontSize: 12), // Adjust font size as needed
                    ),
                  )
                : const SizedBox.shrink(),
            activeColor: Color(0xFF2E3A59),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
