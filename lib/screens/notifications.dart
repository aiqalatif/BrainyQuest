import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1B54),
        elevation: 10,
        shadowColor: Colors.yellow.withOpacity(0.3),
        leadingWidth: 50,
        automaticallyImplyLeading: false,
        // leading: Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Material(
        //     elevation: 1,
        //     color: CustomColors.darkBlue,
        //     shape: const CircleBorder(),
        //     child: IconButton(
        //       icon: const Icon(
        //         Icons.arrow_back_ios,
        //         color: Colors.white,
        //         size: 17,
        //       ),
        //       onPressed: () {
        //         Get.back();
        //       },
        //     ),
        //   ),
        // ),
        title: const CText(
          text: 'Notifications',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // New Notifications Section
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      text: "New",
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    CText(
                      text: "Clear All",
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildNotificationItem(
                  "We think you'll love this video! Watch now and earn rewards tailored just for you.",
                  "2hr ago",
                ),
                _buildNotificationItem(
                  "New rewards are available! Watch a video now to see what you can earn.",
                  "3hr ago",
                ),
                _buildNotificationItem(
                  "Level Up! You've unlocked Level 2 by watching videos. New challenges and rewards await!",
                  "2hr ago",
                ),
                const SizedBox(height: 24),

                // Earlier Notifications Section
                const CText(
                  text: "Earlier",
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 8),
                _buildNotificationItem(
                  "You're on fire! Level 5 unlocked. Explore new games and earn bigger rewards!",
                  "Yesterday",
                ),
                _buildNotificationItem(
                  "You're on fire! Level 5 unlocked. Explore new games and earn bigger rewards!",
                  "Yesterday",
                ),
                _buildNotificationItem(
                  "Well done! You've completed the mission and earned your reward. Head to the Rewards Dashboard to redeem it.",
                  "Yesterday",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String message, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/notification.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      text: message,
                      fontSize: 12,
                      color: Colors.white,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    CText(
                      text: time,
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(
            color: Colors.white38,
            height: 1,
          ),
        ],
      ),
    );
  }
}
