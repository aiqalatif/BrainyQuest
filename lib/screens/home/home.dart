import 'package:brain_master/screens/home/components/level_progress.dart';
import 'package:brain_master/screens/home/components/upcoming_levels.dart';
import 'package:brain_master/screens/home/components/upcoming_missions.dart';
import 'package:brain_master/screens/home/widgets/upcoming_level_row.dart';
import 'package:brain_master/test_file_1.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:brain_master/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60.0), child: CustomAppbar()),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Level Progress'),
                SizedBox(height: 10.h),
                const LevelProgress(),
                const SizedBox(height: 20),
                // const UpcomingLevelRow(),
                // const SizedBox(height: 10),
              const  UpcomingLe(),
                const SizedBox(height: 20),
                _buildSectionTitle('Upcoming Missions'),
                const SizedBox(height: 10),
               const  UpcomingMissions()
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildSectionTitle(String title) {
    return CText(
      text: title,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
