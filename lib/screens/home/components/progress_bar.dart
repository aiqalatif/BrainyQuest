// import 'dart:ui';
//
// import 'package:brain_master/themes/custom_color.dart';
// import 'package:brain_master/utils/custom_text.dart';
// import 'package:brain_master/widgets/custom_button.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class ProgressBar extends StatefulWidget {
//   const ProgressBar({super.key});
//
//   @override
//   State<ProgressBar> createState() => _ProgressBarState();
// }
//
// class _ProgressBarState extends State<ProgressBar> {
//   double progressValue = 0.0;
//
//   @override
//   void initState() {
//     _loadProgress();
//     super.initState();
//   }
//
//   Future<double> calculateProgressPercentage(String userID) async {
//     try {
//       // Fetch the total number of tasks (assuming a separate collection for total tasks)
//       QuerySnapshot totalTasksSnapshot = await FirebaseFirestore.instance
//           .collection('user_task_progress')
//           .where('userID', isEqualTo: userID)
//           .get();
//
//       // Fetch the number of completed tasks
//       QuerySnapshot completedTasksSnapshot = await FirebaseFirestore.instance
//           .collection('user_task_progress')
//           .where('userID', isEqualTo: userID)
//           .where('status', isEqualTo: 'isWatched')
//           .get();
//
//       // Total number of tasks
//       int totalTasks = totalTasksSnapshot.size;
//
//       // Number of completed tasks
//       int completedTasks = completedTasksSnapshot.size;
//
//       // Calculate progress percentage
//       double progressPercentage =
//           totalTasks > 0 ? completedTasks / totalTasks : 0.0;
//
//       return progressPercentage.clamp(
//           0.0, 1.0); // Ensure value is between 0 and 1
//     } catch (e) {
//       print('Error calculating progress: $e');
//       return 0.0;
//     }
//   }
//
//   Future<void> _loadProgress() async {
//     double progress = await calculateProgressPercentage(
//         FirebaseAuth.instance.currentUser!.uid);
//     setState(() {
//       progressValue = progress;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 8,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               LinearProgressIndicator(
//                 value: progressValue,
//                 borderRadius: BorderRadius.circular(10),
//                 backgroundColor: Colors.grey[800],
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//                 minHeight: 15,
//               ),
//               Text(
//                 '${(progressValue * 100).toStringAsFixed(0)}%',
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: InkWell(
//             onTap: () {
//               _showCompletionDialog(context);
//             },
//             child: const Material(
//               elevation: 2,
//               color: CustomColors.darkBlue,
//               shape: CircleBorder(),
//               child: Padding(
//                 padding: EdgeInsets.all(7.0),
//                 child: Image(
//                   height: 12,
//                   image: AssetImage("assets/images/gift_icon.png"),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// void _showCompletionDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     // Allow dismissing by tapping outside the dialog
//     builder: (BuildContext context) {
//       return Stack(
//         children: [
//           // Blurred background
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//             // Adjust the blur intensity
//             child: Container(
//               color: Colors.white
//                   .withOpacity(0.1), // Optional: Semi-transparent background
//             ),
//           ),
//           // Dialog content
//           Center(
//             child: Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               backgroundColor: Colors.transparent,
//               // Set background to transparent for the shadow effect
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF291E50), // Dialog background color
//                   borderRadius: BorderRadius.circular(20.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.white.withOpacity(0.3),
//                       // White shadow with some transparency
//                       blurRadius: 10,
//                       // Adjust the blur radius
//                       spreadRadius: 5, // Adjust the spread radius
//                     ),
//                   ],
//                 ),
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           Image(
//                             image: const AssetImage("assets/images/gift.png"),
//                             height: 60.h,
//                           ),
//                           const SizedBox(height: 16),
//                           const CText(
//                             text: "Level 1 Completed",
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                           const SizedBox(height: 8),
//                           const CText(
//                             maxLines: 2,
//                             text:
//                                 '"Collect Gift" to add the Red Pen to your inventory and move on to the next level!',
//                             fontSize: 8,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w300,
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 16),
//                           SizedBox(
//                               height: 35.h,
//                               child: CustomButton(
//                                   onPress: () {
//                                     Get.back();
//                                   },
//                                   name: "Claim Now")),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       right: 0,
//                       top: 0,
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pop(); // Close the dialog
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF22325C),
//                               // Subtle background color
//                               borderRadius: BorderRadius.circular(
//                                   12), // Optional: Rounded corners
//                             ),
//                             padding: const EdgeInsets.all(4.0),
//                             // Padding around the image
//                             child: Image.asset(
//                               'assets/images/close.png',
//                               // Your close icon image
//                               width: 6, // Adjust the size as needed
//                               height: 6, // Adjust the size as needed
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
