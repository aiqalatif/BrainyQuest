import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/widgets/custom_button.dart';
import 'package:brain_master/utils/custom_text.dart'; // Ensure this import is included
import 'package:brain_master/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:brain_master/services/auth_service/firebase_auth_service.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  bool _obscureText = true;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left_outlined,
                      color: CustomColors.red,
                      size: 35,
                    ),
                  ),
                  const CText(
                    text: 'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container()
                ],
              ),
              SizedBox(height: 16.h),
              const CText(
                text: 'Create a new password to securely access your account',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),
              CustomTextFormField(
                controller: oldPasswordController,
                labelText: 'Abcr3@|',
                prefixIcon: Image.asset(
                  'assets/images/password_lock.png',
                  scale: 4,
                ),
                // Use an image for prefix icon
                suffixIcon: _obscureText
                    ? Image.asset(
                        'assets/images/password_eye.png',
                        scale: 5,
                      ) // Use images for suffix icon
                    : Image.asset(
                        'assets/images/password_eye.png',
                        scale: 5,
                      ),
                onSuffixIconPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                obscureText: _obscureText,
                borderColor: Colors.white,
                focusedBorderColor: Colors.red,
                textColor: Colors.white,
                labelColor: Colors.white70,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                controller: newPasswordController,
                labelText: 'Password',
                prefixIcon: Image.asset(
                  'assets/images/password_lock.png',
                  scale: 4,
                ),
                // Use an image for prefix icon
                suffixIcon: _obscureText
                    ? Image.asset(
                        'assets/images/password_eye.png',
                        scale: 5,
                      ) // Use images for suffix icon
                    : Image.asset(
                        'assets/images/password_eye.png',
                        scale: 5,
                      ),
                onSuffixIconPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                obscureText: _obscureText,
                borderColor: Colors.white,
                focusedBorderColor: Colors.red,
                textColor: Colors.white,
                labelColor: Colors.white70,
              ),
              SizedBox(height: 40.h),
              CustomButton(
                onPress: () {
                  AuthService.changePassword(
                          oldPassword: oldPasswordController.text.trim(),
                          newPassword: newPasswordController.text.trim())
                      .then(
                    (value) => print('successfully password changed'),
                  );
                },
                name: "Submit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
