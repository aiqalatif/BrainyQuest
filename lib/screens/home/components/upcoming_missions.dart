import 'package:brain_master/screens/home/components/mission_switcher.dart';
import 'package:brain_master/screens/home/provider/toggle_provider.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpcomingMissions extends StatelessWidget {
  const UpcomingMissions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OpenProvider>(builder: (context, openProvider, child) {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('switches').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No items found.'));
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
              final mapData = doc.data() as Map<String, dynamic>;
              final missionList = mapData['mission_list'] as List<dynamic>;
              final level = mapData['level'] ?? 'No Level';
              final missionName = mapData['mission_name'] ?? 'No Mission Name';
              return Container(
                decoration: BoxDecoration(
                    color: CustomColors.darkBlue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: CustomColors.lightBlue)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    openProvider.isOpen != false
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: CustomColors.lightBlue)),
                            child: Material(
                              elevation: 10,
                              color: CustomColors.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CText(
                                        text: "Tap to view",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    InkWell(
                                      onTap: () {
                                        openProvider.toggleOpen();
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Material(
                                            elevation: 1,
                                            color: CustomColors.darkBlue,
                                            shape: const CircleBorder(),
                                            child: openProvider.isOpen == false
                                                ? const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_outlined,
                                                    color: Colors.white,
                                                  )
                                                : const Icon(
                                                    Icons.keyboard_arrow_up,
                                                    color: Colors.white,
                                                  )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: CustomColors.lightBlue)),
                            child: Material(
                              elevation: 10,
                              color: CustomColors.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                        'assets/images/upcomming_missions.png',
                                        height: 60),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CText(
                                            text: 'Level $level',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        CText(
                                            text: missionName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            )),
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        openProvider.toggleOpen();
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Material(
                                          elevation: 1,
                                          color: CustomColors.darkBlue,
                                          shape: CircleBorder(),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 10.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: missionList.length,
                      itemBuilder: (context, missionIndex) {
                        final mission =
                            missionList[missionIndex] as Map<String, dynamic>;
                        final missions = mission['missions'] ?? 'No Name';
                        final status = mission['status'] ?? 'No Status';
                        final docId = doc.id;

                        return Column(
                          children: [
                            MissionItem(
                              mission: missions,
                              isSwitched: status,
                              docId: docId,
                              index: missionIndex,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(
                                color: CustomColors.lightBlue,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                ),
              );
            },
          );
        },
      );
    });
  }
}
