import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:brain_master/widgets/custom_appbar.dart';
import 'package:brain_master/widgets/custom_bottom_nav_bar.dart';
import 'package:brain_master/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ResortHealt extends StatelessWidget {
  const ResortHealt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppbar(),
      ),
      body: Container(
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
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
        child: Padding(
          padding: EdgeInsets.all(8.w), // Use ScreenUtil for padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Life Meter
              CText(
                text: "Life Meter",
                fontSize: 14.sp, // Use ScreenUtil for font size
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              // Stack(
              //   children: [
              //     Container(
              //       height: 20.h, // Use ScreenUtil for height
              //       decoration: BoxDecoration(
              //         color: const Color(0xFFFFFFFF).withOpacity(0.2),
              //         borderRadius: BorderRadius.circular(
              //             10.r), // Use ScreenUtil for border radius
              //       ),
              //     ),
              //     Positioned(
              //       left: 0,
              //       child: Row(
              //         children: [
              //           Container(
              //             height: 20.h, // Use ScreenUtil for height
              //             width: 100.w, // Use ScreenUtil for width
              //             decoration: BoxDecoration(
              //               color: Color(0xFFCE1313),
              //               borderRadius: BorderRadius.circular(
              //                   10.r), // Use ScreenUtil for border radius
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     // Positioned(
              //     //
              //     //   child: Image.asset(
              //     //     'assets/images/heart.png',
              //     //     width: 40.w, // Use ScreenUtil for width
              //     //     height: 40.h, // Use ScreenUtil for height
              //     //   ),
              //     // ),
              //   ],
              // ),
              SvgPicture.asset("assets/images/progress_bar.svg"),
              CText(
                text: "Spend 100 gems to restore your each life level",
                fontSize: 14.sp, // Use ScreenUtil for font size
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 30.h),

              // Gem options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGemOption("100 gems", const Color(0xFFDB053A)),
                  _buildGemOption("200 gems", const Color(0xFF22325C)),
                  _buildGemOption("300 gems", const Color(0xFF22325C)),
                ],
              ),
              SizedBox(height: 109.h),
              // Use ScreenUtil for height

              // Restore Button
              CustomButton(
                  onPress: () {
                  },
                  name: "Restore")
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGemOption(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      // Use ScreenUtil for padding
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: CustomColors.lightBlue),
        borderRadius:
            BorderRadius.circular(15.r), // Use ScreenUtil for border radius
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/diamond.png',
            width: 14.w, // Use ScreenUtil for width
            height: 14.h, // Use ScreenUtil for height
          ),
          SizedBox(width: 6.w), // Use ScreenUtil for width
          CText(
            text: text,
            color: Colors.white,
            fontSize: 12.sp, // Use ScreenUtil for font size
          ),
        ],
      ),
    );
  }
}
