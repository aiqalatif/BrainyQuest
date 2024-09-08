import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LevelTask extends StatefulWidget {
  final String docId;
  final Function(String videoUrl, String levelTaskDocID) onPlayTapped;

  const LevelTask({
    Key? key,
    required this.docId,
    required this.onPlayTapped,
  }) : super(key: key);

  @override
  _LevelTaskState createState() => _LevelTaskState();
}

class _LevelTaskState extends State<LevelTask> {
  String? _selectedVideoId;
  int currentIndex = 0;
  late Future<Map<String, dynamic>> _combinedFuture;

  @override
  void initState() {
    super.initState();
    _combinedFuture = _fetchLevelsAndWatchedTasks();
  }

  Future<Map<String, dynamic>> _fetchLevelsAndWatchedTasks() async {
    final userID = FirebaseAuth.instance.currentUser!.uid;

    // Fetch levels_task and user_task_progress concurrently
    var levelsTaskFuture = FirebaseFirestore.instance
        .collection('levels_task')
        .where('levels_ID', isEqualTo: widget.docId)
        .get();

    var userTaskProgressFuture = FirebaseFirestore.instance
        .collection('user_task_progress')
        .where('userID', isEqualTo: userID)
        .get();

    // Wait for both futures to complete
    var results = await Future.wait([levelsTaskFuture, userTaskProgressFuture]);

    // Return a map containing both sets of data
    return {
      'levelsTask': results[0] as QuerySnapshot,
      'userTaskProgress': results[1] as QuerySnapshot,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _combinedFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }

        final videos = snapshot.data!['levelsTask']?.docs ?? [];
        final watchedTasks = snapshot.data!['userTaskProgress']?.docs ?? [];

        if (videos.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            final levelTaskDocID = video.id;
            final videoTitle = video['title'] ?? 'No Title';
            final videoSubtitle = video['subtitle'] ?? 'No Subtitle';
            final videoDuration = video['video_duration'] ?? 'Unknown';
            final thumbnailUrl = video['thumnail_url'] ?? '';

            // Check if the task is watched
            final isWatched = watchedTasks.any((task) => task['task_id'] == levelTaskDocID);

            return Material(
              elevation: 10,
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                decoration: BoxDecoration(
                  color: CustomColors.darkBlue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: CustomColors.lightBlue),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(thumbnailUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  text: videoTitle,
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CText(
                                  text: videoSubtitle,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5.0),
                                      child: Icon(
                                        Icons.watch_later_outlined,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    CText(
                                      text: videoDuration.toString(),
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                          setState(() {
  _selectedVideoId = levelTaskDocID;
  currentIndex = (currentIndex + 1) % (videos.length as int);
});

                            widget.onPlayTapped(
                              video['video_url'] ?? '',
                              levelTaskDocID,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD04959),
                                    Color(0xFFDB053A),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 15),
                                child: Center(
                                  child: CText(
                                    fontSize: 8,
                                    text: "Play",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        if (isWatched)
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 5),
                              CircleAvatar(
                                backgroundColor: Color(0xff00D361),
                                radius: 2,
                              ),
                              SizedBox(width: 2),
                              Text("Watched",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 8,
                                  )),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
