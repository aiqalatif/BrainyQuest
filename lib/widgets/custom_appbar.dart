import 'package:brain_master/screens/notifications.dart';
import 'package:brain_master/screens/profile_screen/edit_profile.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:flutter/material.dart';
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
                color: Colors.white70,
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
      color: CustomColors.purpleColor,
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
          // Background color set karne ke liye
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
        backgroundColor: const Color(0xFF201963),
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
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: CustomColors.darkBlue,
                  borderRadius: BorderRadius.circular(30)),
              child: _buildStatButton(
                '13 gems',
                'assets/images/diamond.png',
                Colors.white,
                (details) {},
              ),
            ),
            SizedBox(width: 5.w),
            Container(
              decoration: BoxDecoration(
                  color: CustomColors.darkBlue,
                  borderRadius: BorderRadius.circular(30)),
              child: _buildStatButton(
                'English',
                'assets/images/language.png',
                Colors.red,
                (details) {
                  _showCustomMenu(context, details.globalPosition);
                },
              ),
            ),
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
                backgroundColor: CustomColors.darkBlue,
                radius: 15,
                child: Image.asset('assets/images/notification.png',
                    width: 15, height: 15, color: Colors.white),
              ),
            ),
          ), // Replacing the Icon with an image
        ]);
  }
}
