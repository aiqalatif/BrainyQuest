import 'package:flutter/material.dart';
import 'package:flutter_application/screens/notifications.dart';
import 'package:flutter_application/screens/profile_screen/edit_profile.dart';
import 'package:flutter_application/themes/custom_color.dart';
import 'package:flutter_application/utils/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  Widget _buildStatButton(
    String label,
    String assetPath,
    Color color,
    GestureTapDownCallback onTapDown,
  ) {
    return GestureDetector(
      onTapDown: onTapDown,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
        child: Row(
          children: [
            Image.asset(
              assetPath,
              width: 15,
              height: 15,
              color: color,
            ),
            const SizedBox(width: 4),
            CText(
              text: label,
              style: const TextStyle(
                fontSize: 5,
                color: Color(0xFF2E3A59),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomMenu(BuildContext context, Offset offset) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      color: CustomColors.lightBlue, // Updated to lightBlue color
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        overlay.size.width - offset.dx,
        overlay.size.height - offset.dy,
      ),
      items: <PopupMenuEntry>[
        const PopupMenuItem<int>(
          height: 25,
          value: 0,
          child: Text(
            style: TextStyle(
              color: Color(0xffCE1313),
            ),
            "English",
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          height: 25,
          value: 1,
          child: Text(
            style: TextStyle(
              color: Color(0xffCE1313),
            ),
            "French",
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 2,
          height: 25,
          child: Text(
            style: TextStyle(
              color: Color(0xffCE1313),
            ),
            "Spanish",
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        print("Selected item: $value");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leadingWidth: 130.w,
        backgroundColor: const Color(0xFF81D4FA),  // Sky blue color
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(EditProfile());
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  radius: 15,
                ),
              ),
              SizedBox(width: 13.h),
              const CText(
                text: "Anabella",
                style: TextStyle(color: Color(0xFF2E3A59), fontSize: 12),
              ),
            ],
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color:  Color(0xFFfed887), // Lighter Sky blue color
                  borderRadius: BorderRadius.circular(30)),
              child: _buildStatButton(
                '13 gems',
                'assets/images/diamond.png',
                Color(0xFF2E3A59),
                (details) {},
              ),
            ),
            SizedBox(width: 5.w),
            // Container(
            //   decoration: BoxDecoration(
            //       color:  Color(0xFFfed887),  // Lighter Sky blue color
            //       borderRadius: BorderRadius.circular(30)),
            //   child: _buildStatButton(
            //     'English',
            //     'assets/images/language.png',
            //     Color(0xFF2E3A59),
            //     (details) {
            //       _showCustomMenu(context, details.globalPosition);
            //     },
            //   ),
            // ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(Notifications());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                backgroundColor: const Color(0xFFfed887),  // Lighter Sky blue color
                radius: 15,
                child: Image.asset('assets/images/notification.png',
                    width: 15, height: 15, color: Color(0xFF2E3A59),),
              ),
            ),
          ), 
        ]);
  }
}
