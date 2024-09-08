import 'package:brain_master/screens/profile_screen/provider_services/edit_profile_provider.dart';
import 'package:brain_master/services/image_picker_services.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:brain_master/utils/custom_toast_message.dart';
import 'package:brain_master/widgets/custom_button.dart';
import 'package:brain_master/widgets/custom_text_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final bool _obscureText = true;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1B54),
        elevation: 10,
        shadowColor: Colors.yellow.withOpacity(0.3),
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 1,
            color: CustomColors.darkBlue,
            shape: const CircleBorder(),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 17,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        title: const CText(
          text: 'Profile',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
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
        child: StreamBuilder<DocumentSnapshot>(
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
            String email = userData['email'] ?? '';
            var imageUrl = userData['imageUrl'];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),
                    Container(
                      height: 150,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 62.h,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60.h,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: imageUrl != null
                                  ? NetworkImage(imageUrl!) as ImageProvider
                                  : const AssetImage(
                                      "assets/images/people.png"),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: InkWell(
                                onTap: () {
                                  _pickImage(context).then((value) {
                                    CustomToast.showToast("Congratulations",
                                        "Image Picked Successfully");
                                  });
                                },
                                child: Image(
                                  height: 40.h,
                                  image: const AssetImage(
                                      "assets/images/camra.png"),
                                )),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _pickImage(context).then((value) {
                          CustomToast.showToast(
                              "Congratulations", "Image Picked Successfully");
                        });
                      },
                      child: const CText(
                        text: "Change Picture",
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomTextFormField(
                      controller: _nameController,
                      labelText: userName,
                      prefixIcon: Image.asset(
                        'assets/images/people.png',
                        scale: 5,
                      ),
                      borderColor: Colors.white,
                      focusedBorderColor: Colors.red,
                      textColor: Colors.white,
                      labelColor: Colors.white70,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: email,
                      prefixIcon: Image.asset(
                        'assets/images/email.png',
                        scale: 5,
                      ),
                      borderColor: Colors.white,
                      focusedBorderColor: Colors.red,
                      textColor: Colors.white,
                      labelColor: Colors.white70,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      controller: _passwordController,
                      labelText: 'Password',
                      prefixIcon: Image.asset(
                        'assets/images/password_lock.png',
                        scale: 4,
                      ),
                      suffixIcon: Consumer<TextFormFieldState>(
                        builder: (context, state, _) {
                          return GestureDetector(
                            onTap: state.toggleObscureText,
                            child: Image.asset(
                              state.obscureText
                                  ? 'assets/images/password_eye.png'
                                  : 'assets/images/password_eye.png',
                              scale: 5,
                            ),
                          );
                        },
                      ),
                      onSuffixIconPressed: () {},
                      obscureText: true,
                      borderColor: Colors.white,
                      focusedBorderColor: Colors.red,
                      textColor: Colors.white,
                      labelColor: Colors.white70,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      prefixIcon: Image.asset(
                        'assets/images/password_lock.png',
                        scale: 4,
                      ),
                      suffixIcon: Consumer<TextFormFieldState>(
                        builder: (context, state, _) {
                          return GestureDetector(
                            onTap: state.toggleObscureText,
                            child: Image.asset(
                              state.obscureText
                                  ? 'assets/images/password_eye.png'
                                  : 'assets/images/password_eye.png',
                              scale: 5,
                            ),
                          );
                        },
                      ),
                      onSuffixIconPressed: () {
                        // setState(() {
                        //   _obscureText = !_obscureText;
                        // });
                      },
                      obscureText: true,
                      borderColor: Colors.white,
                      focusedBorderColor: Colors.red,
                      textColor: Colors.white,
                      labelColor: Colors.white70,
                    ),
                    SizedBox(height: 70.h),
                    CustomButton(
                        onPress: () {
                          profileProvider.submitData(
                            _nameController.text,
                            _emailController.text,
                          );
                        },
                        name: "Save Changes"),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    String? downloadUrl = await ImagePickerServices.pickImageAndUpload();
    if (downloadUrl != null) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.setImageUrl(downloadUrl);
    } else {
      CustomToast.showToast("Sorry", "Image selection failed.");
    }
  }
}
