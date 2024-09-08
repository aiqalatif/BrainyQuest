import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class YourWidget extends StatefulWidget {
  final String docId;

  YourWidget({Key? key, required this.docId}) : super(key: key);

  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  FlickManager? flickManager;
  FlickManager? byDefultflickManager;

  @override
  void initState() {
    super.initState();
    _initializeByDefaultFlickManager();
  }

  @override
  void dispose() {
    flickManager
        ?.dispose();
    byDefultflickManager?.dispose();
    super.dispose();
  }

  Future<void> _initializeByDefaultFlickManager() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('levels_task')
          .where('levels_ID', isEqualTo: widget.docId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var docSnapshot = querySnapshot.docs.first;
        String videoUrl = docSnapshot['video_url'];

        setState(() {
          byDefultflickManager = FlickManager(
            videoPlayerController: VideoPlayerController.network(videoUrl),
          );
        });
      } else {
        print('No documents found in Firestore');
      }
    } catch (e) {
      print('Failed to fetch video URL: $e');
    }
  }

  Future<void> _initializeFlickManager({String? url}) async {
    if (url != null && url.isNotEmpty) {
      print("Updating FlickManager with new URL");
      print("asdfca $url");
      setState(() {
        flickManager?.dispose();
        byDefultflickManager = null;
        flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.network(url),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: (byDefultflickManager != null
                  ?
                  // Container(
                  //         height: 300,
                  //         color: Colors.red,
                  //       )
                  FlickVideoPlayer(
                      flickManager: byDefultflickManager!,
                      flickVideoWithControls: const FlickVideoWithControls(
                        controls: FlickPortraitControls(),
                        videoFit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(
                      child: Text("no video byDefultflickManager"),
                    )),

              // FlickVideoPlayer(
              //         flickManager: flickManager!,
              //         flickVideoWithControls: const FlickVideoWithControls(
              //           controls: FlickPortraitControls(),
              //           videoFit: BoxFit.cover,
              //         ),
              //       ),
            ),
            flickManager != null
                ?
                // Container(
                //         height: 300,
                //         color: Colors.blue,
                //       )
                FlickVideoPlayer(
                    flickManager: flickManager!,
                    flickVideoWithControls: const FlickVideoWithControls(
                      controls: FlickPortraitControls(),
                      videoFit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(
                    child: Text("no video flickManager"),
                  ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('levels_task')
                    .where('levels_ID', isEqualTo: widget.docId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }

                  final videos = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      final levelTaskDocID = video.id;
                      final videoTitle = video['title'] ?? 'No Title';
                      final videoSubtitle = video['subtitle'] ?? 'No Title';
                      final videoDuration =
                          video['video_duration'] ?? 'Unknown';
                      final thumbnailUrl = video['thumnail_url'] ?? '';

                      return Material(
                        elevation: 10,
                        color: Colors.transparent,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          decoration: BoxDecoration(
                            color: CustomColors.darkBlue,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: CustomColors.lightBlue),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            padding:
                                                EdgeInsets.only(right: 5.0),
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
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  final videoUrl = video['video_url'] ??
                                      'https://www.pexels.com/video/a-person-using-a-treadmill-5319999/';
                                  print("videoUrl $videoUrl");
                                  await _initializeFlickManager(url: videoUrl);

                                  try {
                                    CollectionReference collectionRef =
                                        FirebaseFirestore.instance
                                            .collection("user_task_progress");

                                    await collectionRef.doc().set({
                                      "status": "isWatched",
                                      "userID": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "task_id": levelTaskDocID,
                                      "gems": 30,
                                    });

                                    print('Value updated successfully.');
                                  } catch (e) {
                                    print('Failed to update value: $e');
                                  }
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
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
