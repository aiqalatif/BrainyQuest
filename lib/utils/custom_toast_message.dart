import 'package:brain_master/themes/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomToast {
  static void showToast(String title, String subtitle, {Color? backgroundColor, Color? textColor}) {
    Get.snackbar(
      title,
      subtitle,
      backgroundColor: backgroundColor ?? CustomColors.purpleColor,
      colorText: textColor ?? CustomColors.red,
      snackPosition: SnackPosition.TOP,
      borderRadius: 15,
      duration: const Duration(seconds: 3),
    );
  }
}
