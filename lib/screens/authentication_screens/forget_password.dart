import 'package:brain_master/screens/authentication_screens/enter_code.dart';
import 'package:brain_master/screens/authentication_screens/reset_password.dart';
import 'package:brain_master/screens/authentication_screens/sign_in/sign_in.dart';
import 'package:brain_master/services/auth_service/firebase_auth_service.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/widgets/custom_button.dart';
import 'package:brain_master/utils/custom_text.dart'; // Ensure this import is included
import 'package:brain_master/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80.h,
                ),
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
                      text: 'Forget Password?',
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: CText(
                    text: 'Can’t remember your password? Reset \n it now',
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 46.h),
                CustomTextFormField(
                  controller: _emailcontroller,
                  labelText: 'example@|',
                  prefixIcon: Image.asset(
                    'assets/images/email.png',
                    scale: 5,
                  ),
                  // Use an image for prefix icon
                  borderColor: Colors.white,
                  focusedBorderColor: Colors.red,
                  textColor: Colors.white,
                  labelColor: Colors.white70,
                ),

                // TextField(
                //   decoration: InputDecoration(
                //     hintText: 'example@',
                //     hintStyle: const TextStyle(color: Colors.white),
                //     prefixIcon:
                //     const Icon(Icons.email, color: Colors.white),
                //     filled: true,
                //     fillColor: Colors.transparent,
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(30),
                //       borderSide: BorderSide(color: Colors.red, width: 1.5.w),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(30),
                //       borderSide: BorderSide(color: Colors.redAccent, width: 1.5.w),
                //     ),
                //   ),
                //   style: const TextStyle(color: Colors.white70,fontSize: 12),
                // ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CText(
                      text: 'Remember password? ',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(SignInScreen());
                      },
                      child: const CText(
                        text: 'Login',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 46.h),
                CustomButton(
                  onPress: () {
                    AuthService.sendPasswordResetEmail(
                            email: _emailcontroller.text.trim())
                        .then(
                      (value) => {Get.to(EnterCode())},
                    );

                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EnterCode()),
                    );*/
                  },
                  name: "Recover",
                ),
                // CustomButton(
                //   onPress: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => EnterCode()),
                //     );
                //   },
                //   name: "Enter Code",
                // ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
