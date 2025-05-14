
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/onboarding_screens/on_boarding.dart';
import 'package:flutter_application/utils/custom_text.dart';
import 'package:flutter_application/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter_application/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Ensure this import is present

import 'package:get/get.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
           colors: [
     Color(0xFFfed887),
              Color(0xFFFCCDE2),// Slightly deeper pastel pink
  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            // Example of using ScreenUtil for padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  height: 180.h,
                ),
                //SizedBox(height: 1.h),
                const CText(
                  text: 'Welcome to Brain Master, an e-learning gaming platform where you will learn a lot with daily missions and level’s content.',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 45.h),
                CustomButton(
                  name: "Get Started",
                  onPress: () {
                    Get.offAll(() => 
                    FirebaseAuth.instance.currentUser != null ? const CustomNavBar() : const OnboardingScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
