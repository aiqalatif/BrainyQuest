import 'dart:ui';

import 'package:brain_master/screens/resort_healt.dart';
import 'package:brain_master/screens/stats/components/gift_collected_widget.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:brain_master/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h), // Responsive height
        child: const CustomAppbar(),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF131B63),
              Color(0xFF481162),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 22.w, top: 10.h),
                child: const CText(
                  text: 'Life Meter',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.w),
                child: Image.asset(
                  'assets/images/life_meter.png',
                  height: 54.h, // Responsive height
                  width: 373.w, // Responsive width
                ),
              ),
//              _buildHealthReminder(),

              InkWell(
                onTap: () {
                  Get.to(ResortHealt());
                },
                child: Image.asset(
                  'assets/images/health_reminder.png',
                  //height: 54.h, // Responsive height
                  //width: 373.w, // Responsive width
                ),
              ),
              SizedBox(height: 20.h),
              // Responsive height
              _buildSectionTitle('Level Progress'),
              SizedBox(height: 10.h),
              // Res
              // ponsive height
              _buildLevelProgressCard(),
              SizedBox(height: 20.h),
              // Responsive height
              _buildSectionTitle('Gift Collected'),
              SizedBox(height: 10.h),
              // Responsive height
              GiftCollectedWidget(),
              SizedBox(height: 20.h),
              // Responsive height
              _buildSectionTitle('Completed Missions'),
              SizedBox(height: 10.h),
              // Responsive height
              _buildUpcomingMissions(),
              SizedBox(height: 20.h),
              // Responsive height
              _buildSectionTitle('Gems Collected'),
              SizedBox(height: 10.h),
              // Responsive height
              _buildGemsCollected(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthReminder() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF00D361),
        borderRadius: BorderRadius.circular(30.r), // Responsive radius
      ),
      child: ListTile(
        leading: Image.asset(
          'assets/images/star.png',
          height: 34.h, // Responsive height
          width: 34.w, // Responsive width
        ),
        title: CText(
          text: 'Health Reminder',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp, // Responsive font size
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Spend 100 gems to restore your each life level',
          style: TextStyle(
              color: Colors.black,
              fontSize: 10.sp, // Responsive font size
              fontWeight: FontWeight.w400),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFD04959), // Start color
                Color(0xFFDB053A), // End color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r), // Responsive radius
          ),
          child: SizedBox(
            height: 25.h,
            child: TextButton(
              onPressed: () {
                Get.to(const ResortHealt());
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                // Use transparent background for gradient
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.r), // Responsive radius
                ),
              ),
              child: CText(
                text: 'Restore',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp, // Responsive font size
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildGiftCollected() {
  //   return Container(
  //     // Responsive height
  //     decoration: BoxDecoration(
  //       color: CustomColors.darkBlue,
  //       borderRadius: BorderRadius.circular(10.r), // Responsive radius
  //       border: Border.all(color: CustomColors.lightBlue),
  //     ),
  //     child: GridView.builder(
  //       padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
  //       // Responsive padding
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 5,
  //         mainAxisSpacing: 4.w, // Responsive spacing
  //         crossAxisSpacing: 4.w, // Responsive spacing
  //         mainAxisExtent: 78.h, // Responsive extent
  //       ),
  //       itemCount: 15,
  //       itemBuilder: (context, index) {
  //         return Column(
  //           children: [
  //             index > 0
  //                 ? CircleAvatar(
  //                     backgroundColor: Colors.transparent,
  //                     backgroundImage: AssetImage("assets/images/unlock.png"),
  //                   )
  //                 : Container(
  //                     decoration: BoxDecoration(
  //                       color: CustomColors.darkBlue,
  //                       shape: BoxShape.circle,
  //                       border:
  //                           Border.all(color: Colors.yellow.withOpacity(0.2)),
  //                     ),
  //                     child: Padding(
  //                       padding: EdgeInsets.all(8.w), // Responsive padding
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             "assets/images/giftss.png",
  //                             height: 20.h, // Responsive height
  //                           ),
  //                           SizedBox(height: 5.h), // Responsive height
  //                         ],
  //                       ),
  //                     )),
  //             CText(
  //               text: 'Red Pen',
  //               style: TextStyle(
  //                   color: Colors.white70,
  //                   fontSize: 4.sp,
  //                   fontWeight: FontWeight.bold // Responsive font size
  //                   ),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildGemsCollected() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.darkBlue,
        borderRadius: BorderRadius.circular(10.r), // Responsive radius
        border: Border.all(color: CustomColors.lightBlue),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CText(
              text: 'Total Gems Collected',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500 // Responsive font size
                  ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/diamond.png",
                  width: 20.w, // Responsive width
                  height: 20.h, // Responsive height
                ),
                SizedBox(width: 4.w), // Responsive width
                CText(
                  text: "1400 gems",
                  style: TextStyle(
                    fontSize: 10.sp, // Responsive font size
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelProgressCard() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.darkBlue,
        borderRadius: BorderRadius.circular(10.r), // Responsive radius
        border: Border.all(color: CustomColors.lightBlue),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        // Responsive padding
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomColors.purpleColor,
                borderRadius: BorderRadius.circular(10.r), // Responsive radius
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                // Responsive padding
                child: Image.asset(
                  "assets/images/level_1_icon.png",
                  height: 53.h, // Responsive height
                ),
              ),
            ),
            SizedBox(width: 16.w), // Responsive width
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    text: 'Level 01',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h), // Responsive height

                  CText(
                    text: 'The Playground',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp, // Responsive font size
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Transform.scale(
                      scale: 1.3, // Adjust the scale factor as needed
                      child: Image.asset(
                        'assets/images/progressbar.png',
                        width: double
                            .infinity, // Makes the image stretch across the width
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    // Responsive radius
                    border: Border.all(color: const Color(0xff36487A)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 5.h, horizontal: 5.w), // Responsive padding
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/diamond.png",
                          width: 15.w, // Responsive width
                          height: 15.h, // Responsive height
                        ),
                        SizedBox(width: 4.w), // Responsive width
                        CText(
                          text: "136 gems",
                          style: TextStyle(
                            fontSize: 5.sp, // Responsive font size
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 45.h), // Responsive height
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CText(
      text: title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp, // Responsive font size
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildUpcomingMissions() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.darkBlue,
        borderRadius: BorderRadius.circular(10.r), // Responsive radius
        border: Border.all(color: CustomColors.lightBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r), // Responsive radius
              border: Border.all(color: CustomColors.lightBlue),
            ),
            child: Material(
              elevation: 10,
              color: CustomColors.darkBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r), // Responsive radius
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w), // Responsive padding
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/upcomming_missions.png',
                      height: 60.h, // Responsive height
                    ),
                    SizedBox(width: 10.w), // Responsive width
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          text: 'Level 09',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp, // Responsive font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CText(
                          text: 'Your first mission',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp, // Responsive font size
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      // Responsive padding
                      child: const Material(
                        elevation: 1,
                        color: CustomColors.darkBlue,
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
