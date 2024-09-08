import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:brain_master/screens/home/components/upcoming_missions.dart';
import 'package:brain_master/screens/home/home.dart';
import 'package:brain_master/screens/notifications.dart';
import 'package:brain_master/screens/profile_screen/user_profile.dart';
import 'package:brain_master/screens/stats/stats.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: CustomColors.purpleColor,
      body: _pages[_currentIndex], // Display the current page
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: const Color(0xFF22325C),
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
                  color: _currentIndex == 0 ? Colors.red : null,
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
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: SizedBox(
              width: 24, // Adjust width as needed
              height: 24, // Adjust height as needed
              child: Center(
                child: Image(
                  height: 18,
                  color: _currentIndex == 1 ? Colors.red : null,
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
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: SizedBox(
              width: 24, // Adjust width as needed
              height: 24, // Adjust height as needed
              child: Center(
                child: Image(
                  height: 20,
                  color: _currentIndex == 2 ? Colors.red : null,
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
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: SizedBox(
              width: 24, // Adjust width as needed
              height: 24, // Adjust height as needed
              child: Center(
                child: Image(
                  height: 18,
                  color: _currentIndex == 3 ? Colors.red : null,
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
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
