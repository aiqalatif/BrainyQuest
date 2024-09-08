import 'dart:ui';

import 'package:brain_master/screens/authentication_screens/sign_in/sign_in.dart';
import 'package:brain_master/screens/home/components/mission_switcher.dart';
import 'package:brain_master/screens/profile_screen/edit_profile.dart';
import 'package:brain_master/screens/profile_screen/provider_services/switchProvider.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:brain_master/utils/custom_toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brain_master/widgets/custom_appbar.dart';
import 'package:brain_master/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppbar(),
      ),
      backgroundColor: const Color(0xFF201963), // Dark background color
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text("User data not found"));
            }

            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;

            String userName = userData['userName'] ?? '';
            int gems = userData['gems'] ?? '';

            int level = userData['level'] ?? '';
            var imageUrl = userData['imageUrl'];

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/images/Component.svg",
                        fit: BoxFit.cover,
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        child: Container(
                          color: Colors.black.withOpacity(
                              0), // Optional: Adjust opacity if needed
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 160.h,
                  // Responsive height
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF291E50),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r), // Responsive radius
                        topRight: Radius.circular(40.r),
                      ),
                      border: Border(
                        top: BorderSide(
                            color: Colors.white,
                            width: 1.w), // Responsive width
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
                    // Responsive padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Level and Gems
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/medal.png',
                                  width: 19.w, // Responsive width
                                  height: 16.h, // Responsive height
                                ),
                                SizedBox(width: 3.w),
                                CText(
                                  text: "Lv.$level",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10.sp),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/diamond.png',
                                  width: 19.w, // Responsive width
                                  height: 16.h, // Responsive height
                                ),
                                SizedBox(width: 8.w), // Responsive width

                                CText(
                                  text: gems.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp, // Responsive font size
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 112.h), // Responsive height

                        // Support Section
                        _buildProfileOption(
                          imagePath: 'assets/images/support.png',
                          text: 'Support',
                          onTap: () {
                            // Navigate to support page or handle action
                          },
                        ),

                        // Notifications Section
                        _buildProfileOption(
                          imagePath: 'assets/images/notification2.png',
                          text: 'Notifications',
                          trailing: Consumer<SwitchProvider>(
                            builder: (context, switchProvider, child) {
                              return CustomSwitch(
                                value: switchProvider.isSwitched,
                                onChanged: (value) {
                                  switchProvider.toggleSwitch(value);
                                },
                              );
                            },
                          ),
                          onTap: () {},
                        ),

                        // Privacy and Policy Section
                        _buildProfileOption(
                          imagePath: 'assets/images/privacy_policy.png',
                          text: 'Privacy and Policy',
                          onTap: () {
                            // Navigate to privacy and policy page or handle action
                          },
                        ),

                        // Logout Section
                        _buildProfileOption(
                          imagePath: 'assets/images/logout.png',
                          text: 'Logout',
                          textColor: const Color(0xFFFD0320),
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                              CustomToast.showToast(
                                  "Congratulations", "Logout Successfully");

                              Get.offAll(const SignInScreen());
                            } catch (e) {
                              print('Error logging out: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Error logging out. Please try again.')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 60.h, // Responsive height
                  left: 0,
                  right: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
                    // Responsive padding
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 42.h,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 40.h,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: imageUrl != null
                                      ? NetworkImage(imageUrl!) as ImageProvider
                                      : const AssetImage(
                                          "assets/images/people.png"),
                                ),
                              ),

                              SizedBox(
                                height: 5.h,
                              ),
                              CText(
                                text: userName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp, // Responsive font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 20.h), // Responsive height
                              SizedBox(
                                height: 30.h, // Responsive height
                                width: 205.w, // Responsive width
                                child: CustomButton(
                                  onPress: () {
                                    Get.to(const EditProfile());
                                  },
                                  name: "Edit",
                                  fontSize: 10.sp, // Responsive font size
                                ),
                              ),
                              SizedBox(height: 24.h), // Responsive height
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildProfileOption({
    required String imagePath, // Path to the image asset
    required String text,
    Color textColor = Colors.white,
    Widget? trailing, // This will be used for images or other widgets
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
      // Responsive padding
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w), // Responsive padding
                  decoration: BoxDecoration(
                    color: const Color(0xFF353565),
                    borderRadius:
                        BorderRadius.circular(30.r), // Responsive radius
                  ),
                  child: Image.asset(
                    imagePath,
                    width: 15.w, // Responsive width
                    height: 15.h, // Responsive height
                  ),
                ),
                SizedBox(width: 12.w), // Responsive width

                CText(
                  text: text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 10.sp, // Responsive font size
                  ),
                )
              ],
            ),
            if (trailing != null)
              trailing
            else
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_forward_ios,
                    color: Colors.white, size: 18),
              ),
            // Static size for fallback
          ],
        ),
      ),
    );
  }
}
