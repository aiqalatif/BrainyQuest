import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftCollectedWidget extends StatelessWidget {
  const GiftCollectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.darkBlue,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: CustomColors.lightBlue),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('gifts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          var gifts = snapshot.data!.docs;

          return GridView.builder(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 4.w,
              crossAxisSpacing: 4.w,
              mainAxisExtent: 78.h,
            ),
            itemCount: gifts.length,
            itemBuilder: (context, index) {
              var gift = gifts[index];
              var status = gift['status']; // Firestore se status get kiya
              var giftName =
                  gift['gift_name']; // Firestore se gift_name get kiya

              return Column(
                children: [
                  status == 'completed'
                      ? const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage("assets/images/unlock.png"),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: CustomColors.darkBlue,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.yellow.withOpacity(0.2)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/giftss.png",
                                  height: 20.h,
                                ),
                                SizedBox(height: 5.h),
                              ],
                            ),
                          )),
                  status == 'completed'
                      ? CText(
                          text: 'Locked', // Display gift name
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 4.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : CText(
                          text: giftName ?? 'Unknown', // Display gift name
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 4.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
