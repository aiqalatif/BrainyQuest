// import 'package:brain_master/themes/custom_color.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// class CustomArrowButton extends StatelessWidget {
//   final Icon icon;
//   final OnTap onpressed;
//   const CustomArrowButton({super.key, required this.icon, required this.onpressed});

//   @override
//   Widget build(BuildContext context) {
//     return  InkWell(
//       onTap: onpressed,
//       child: Padding(
//                 padding: EdgeInsets.only(right: 16.h),
//                 child:  Material(
//                   elevation: 1,
//                   color: CustomColors.darkBlue,
//                   shape: CircleBorder(),
//                   child: icon,
//                 ),
//               ),
//     );
//   }
// }