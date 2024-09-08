import 'package:brain_master/screens/authentication_screens/forget_password.dart';
import 'package:brain_master/screens/authentication_screens/reset_password.dart';
import 'package:brain_master/screens/authentication_screens/sign_in/components/form.dart';
import 'package:brain_master/services/auth_service/firebase_auth_service.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:brain_master/widgets/custom_button.dart';
import 'package:brain_master/widgets/custom_text_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_bottom_nav_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserData() async {
    try {
      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Reference to the user's document
      DocumentReference userDoc = _firestore.collection('users').doc(userId);

      // Check if the document exists
      DocumentSnapshot docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        // Document exists, so the user already exists
        print('User already exists with ID: $userId');
      } else {
        // Document does not exist, so add the user data
        Map<String, dynamic> data = {
          'email': _emailController.text.trim(),
          'gems': 0,
          'imageUrl': '',
          'userName': '',
          "userID": userId,
          "level": 1,
        };

        await userDoc.set(data);
        print('Data added successfully!');
      }
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.h,
                ),
                const CText(
                  text: 'Welcome!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.h),
                const CText(
                  text: 'Enter your credentials to access your account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 59.h),
                FormComponent(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),

                // Form widget added here
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: CustomColors.red,
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: const BorderSide(color: Colors.redAccent),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword()),
                            );
                          },
                          child: const CText(
                            text: 'Remember me',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => ForgetPassword());
                      },
                      child: const CText(
                        text: 'Forget Password?',
                        style: TextStyle(color: Colors.redAccent, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                // Button with form validation
                CustomButton(
                  name: "Login",
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      AuthService.signInWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ).then(
                        (value) {
                          Get.offAll(const CustomNavBar());
                          addUserData();
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 1.h,
                        width: 140.w,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        )),
                    const CText(
                      text: "OR",
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    Container(
                        height: 1.h,
                        width: 140.w,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.transparent],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 40.h),
                const SocialButton(
                  iconPath: 'assets/images/google.png',
                  text: 'Continue with Google',
                ),
                SizedBox(height: 15.h),
                const SocialButton(
                  iconPath: 'assets/images/fb.png',
                  text: 'Continue with Facebook',
                ),
                SizedBox(height: 15.h),
                const SocialButton(
                  iconPath: 'assets/images/apple.png',
                  text: 'Continue with Apple',
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String iconPath;
  final String text;

  const SocialButton({
    Key? key,
    required this.iconPath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.white70),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Aligns children to the start
          children: [
            _buildIcon(iconPath),
            SizedBox(
              width: 150.w,
              child: CText(
                text: text,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String path) {
    return SizedBox(
      height: 18.h, // Set height to 18
      width: 22.w, // Set width to 22
      child: Image.asset(
        path,
        fit: BoxFit.contain,
      ),
    );
  }
}
