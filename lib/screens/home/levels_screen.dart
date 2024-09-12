import 'package:brain_master/model/task_model.dart';
import 'package:brain_master/provider/level_provider.dart';
import 'package:brain_master/screens/home/components/level_task.dart';
import 'package:brain_master/screens/home/components/shimer.dart';
import 'package:brain_master/themes/custom_color.dart';
import 'package:brain_master/utils/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';




class LevelScreen extends StatefulWidget {
  LevelScreen({super.key, required this.docId, required this.level});
  
  final String docId;
  final int level;

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  void initState() {
    super.initState();
    final levelProvider = Provider.of<LevelProvider>(context, listen: false);
    levelProvider.clearManagers(); // Clear any existing managers before initializing
    levelProvider.initializeByDefaultFlickManager(widget.docId);
    levelProvider.loadProgress(widget.docId);
  }

  @override
  void dispose() {
    final levelProvider = Provider.of<LevelProvider>(context, listen: false);
    levelProvider.flickManager?.dispose();
    levelProvider.byDefaultFlickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    print(widget.docId);
    print("****************************");
    return Consumer<LevelProvider>(
      builder: (context, levelProvider, child) {
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            title: Text(
              'Level ${widget.level}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: Container(
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
            child: levelProvider.levelData == null
                ? ShimmerListView() // Show shimmer loading while waiting for data
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Gift Awaiting',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    LinearProgressIndicator(
                                      value: levelProvider.progressValue,
                                      borderRadius: BorderRadius.circular(10),
                                      backgroundColor: Colors.grey[800],
                                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                                      minHeight: 15,
                                    ),
                                    Text(
                                      '${(levelProvider.progressValue * 100).toStringAsFixed(0)}%',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    _showCompletionDialog(context);
                                  },
                                  child: const Material(
                                    elevation: 2,
                                    color: CustomColors.darkBlue,
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: EdgeInsets.all(7.0),
                                      child: Image(
                                        height: 35,
                                        width: 35,
                                        image: AssetImage('assets/images/gift.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (levelProvider.byDefaultFlickManager != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                height: 250.h,
                                child: FlickVideoPlayer(
                                  flickManager: levelProvider.byDefaultFlickManager!,
                                  flickVideoWithControls: const FlickVideoWithControls(
                                    controls: FlickPortraitControls(),
                                    videoFit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          if (levelProvider.flickManager != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                height: 250.h,
                                child: FlickVideoPlayer(
                                  flickManager: levelProvider.flickManager!,
                                  flickVideoWithControls: const FlickVideoWithControls(
                                    controls: FlickPortraitControls(),
                                    videoFit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.white, fontSize: 15),
                              children: [
                                TextSpan(
                                  text: levelProvider.isExpanded
                                      ? levelProvider.subtitle
                                      : '${levelProvider.subtitle!.substring(0, 100)}...',
                                ),
                                TextSpan(
                                  text: levelProvider.isExpanded
                                      ? ' Read Less'
                                      : ' Read More',
                                  style: const TextStyle(color: Colors.red),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      levelProvider.toggleExpansion();
                                    },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          LevelTask(
                            docId: widget.docId,
                            onPlayTapped: (videoUrl, levelTaskDocID) async {
                              print("videoUrl $videoUrl");
                              await levelProvider.initializeFlickManager(url: videoUrl, levelTaskDocID: levelTaskDocID);

                              try {
                                CollectionReference collectionRef = FirebaseFirestore.instance.collection("user_task_progress");

                                UserTaskProgress userTaskProgress = UserTaskProgress(
                                  status: "isWatched",
                                  userID: FirebaseAuth.instance.currentUser!.uid,
                                  taskId: levelTaskDocID,
                                  gems: 30,
                                  videoPlayed: videoUrl,
                                );

                                await collectionRef.add(userTaskProgress.toMap());
                                print("Document successfully added.");

                                // Reload progress after updating
                                await levelProvider.loadProgress(widget.docId);
                              } catch (e) {
                                print('Failed to update value: $e');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }



  

  void _showCompletionDialog(BuildContext context, ) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: const  Color(0xFF291E50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Container(
              height: 353.h,
              width: 357.w,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.h),
                  Image.asset(
                    'assets/images/gift.png',
                    height: 107.h,
                    width: 145.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Level 1 Completed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Collect Gift to add the Red Pen to your inventory and move on to the next level!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 36.h),
                  SizedBox(
                    height: 35.h,
                    width: 257.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        // await provider.sendDataToFirebase(widget.level, 'completed', 'Completion Gift');
                        // await provider.updateUserGems(175);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Claim Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: IconButton(
                icon: const  Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
}