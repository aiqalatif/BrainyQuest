import 'package:brain_master/screens/home/levels_screen.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LevelProgress extends StatelessWidget {
  const LevelProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('levels')
          .where("status", isEqualTo: "unlock")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: BoxDecoration(
              color: CustomColors.darkBlue,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: CustomColors.lightBlue),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColors.purpleColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      child: Image.asset(
                        "assets/images/level_1_icon.png",
                        height: 53.h,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       const CText(
                          text: "Loading...",
                          style:  TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      const   CText(
                          text: "Loading...",
                          style:  TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Transform.scale(
                            scale: 1.3, // Adjust the scale factor as needed
                            child: Image.asset(
                              'assets/images/progressbar.png',
                              width: double
                                  .infinity, // Stretches the image across the width
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0xff36487A)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/diamond.png",
                                width: 15,
                                height: 15,
                              ),
                              const SizedBox(width: 4),
                            const  CText(
                                text: "Loading...",
                                style:  TextStyle(
                                    fontSize: 5,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: Image.asset(
                          "assets/images/play_button.png",
                          height: 30.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No items found.'));
        }

        final documents = snapshot.data!.docs;

        final document = documents[0];
        final docId = document.id;
        final levelTitle = document['title'] ?? 'Level 1';
        final subtitle = document['subtitle'] ?? 'Level 1';
        final gems = document['gems'] ?? 0;

        return Container(
          decoration: BoxDecoration(
            color: CustomColors.darkBlue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: CustomColors.lightBlue),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: CustomColors.purpleColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: Image.asset(
                      "assets/images/level_1_icon.png",
                      height: 53.h,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        text: levelTitle,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      CText(
                        text: subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Transform.scale(
                          scale: 1.3, // Adjust the scale factor as needed
                          child: Image.asset(
                            'assets/images/progressbar.png',
                            width: double
                                .infinity, // Stretches the image across the width
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xff36487A)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/diamond.png",
                              width: 15,
                              height: 15,
                            ),
                            const SizedBox(width: 4),
                            CText(
                              text: "$gems gems",
                              style: const TextStyle(
                                  fontSize: 5,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(LevelScreen(
                          docId: docId,
                          level: 1,
                        ));
                      },
                      child: Image.asset(
                        "assets/images/play_button.png",
                        height: 30.h,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
