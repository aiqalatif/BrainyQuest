import 'package:brain_master/screens/authentication_screens/sign_in/sign_in.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:brain_master/widgets/custom_bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    OnboardingPage(
      title: "",
      description:
          "Welcome to Brain Master! Watch engaging videos and earn gems effortlessly. Start collecting now!",
      imageAsset: "assets/images/logo.png",
    ),
    OnboardingPage(
      title: "",
      description:
          "Explore diverse video content while earning gems with every view. Your journey to rewards begins here!",
      imageAsset: "assets/images/logo.png",
    ),
    OnboardingPage(
      title: "",
      description:
          "Earn gems simply by watching videos you love. Collect enough gems to redeem exciting gifts.",
      imageAsset: "assets/images/logo.png",
    ),
    OnboardingPage(
      title: "",
      description:
          "Join our community of video enthusiasts. Watch, earn gems, and redeem gifts - it's that simple!",
      imageAsset: "assets/images/logo.png",
    ),
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  void _onSkipPressed() {
    // _pageController.jumpToPage(_pages.length - 1);
    Get.to(SignInScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF131B63),
              Color(0xFF481162),
            ], // Gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return _pages[index];
              },
            ),
            Positioned(
              bottom: 80, // Adjust the bottom position of dots
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildDot(index),
                ),
              ),
            ),
            Positioned(
              bottom: 63, // Adjusted bottom value for buttons
              left: 30, // Added left padding
              child: TextButton(
                onPressed: _onSkipPressed,
                child: const CText(
                  text: 'Skip',
                  style: TextStyle(color: Colors.white24, fontSize: 14),
                ),
              ),
            ),
            Positioned(
              bottom: 63, // Adjusted bottom value for buttons
              right: 30, // Added right padding
              child: TextButton(
                onPressed: _onNextPressed,
                child: Text(
                  _currentPage == _pages.length - 1 ? "Next" : "Next",
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10.h,
      width: 10.w,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.white : Colors.white10,
        shape: BoxShape.circle,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;

  OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      // Adjust horizontal padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imageAsset,
            height: 156.h,
          ),
          SizedBox(height: 12.h), // Reduce the height here to reduce space
          CText(
            text: description,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
