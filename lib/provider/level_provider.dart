import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class LevelProvider with ChangeNotifier {
  FlickManager? flickManager;
  FlickManager? byDefaultFlickManager;
  double progressValue = 0.0;
  bool _isExpanded = false;
  String? _levelTaskDocID;

  bool get isExpanded => _isExpanded;

  void toggleExpansion() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
String? title;
  int? gems;
  String? subtitle;
  @override
  Map<String, dynamic>? _levelData;

  Map<String, dynamic>? get levelData => _levelData;

  Future<void> fetchLevelData(String docId) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('levels').doc(docId).get();
    _levelData = snapshot.data() as Map<String, dynamic>;
    notifyListeners(); // Notify listeners when data is fetched
  }

  void clearLevelData() {
    _levelData = null;
    notifyListeners();
  }
void clearManagers() {
  
  flickManager?.dispose();
  byDefaultFlickManager?.dispose();
  flickManager = null;
  byDefaultFlickManager = null;
}
 @override
void dispose() {
  flickManager?.dispose();
  byDefaultFlickManager?.dispose();
  super.dispose();
}

  // Future<void> fetchLevelData(String docId) async {
  //   try {
  //     DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
  //         .collection('levels')
  //         .doc(docId)
  //         .get();

  //     if (docSnapshot.exists) {
  //       var documentData = docSnapshot.data() as Map<String, dynamic>;
  //       title = documentData['title'];
  //       gems = documentData['gems'];
  //       subtitle = documentData['subtitle'];
  //       notifyListeners();
  //     } else {
  //       print('Document does not exist.');
  //     }
  //   } catch (e) {
  //     print('Failed to fetch document: $e');
  //   }
  // }
  Future<void> initializeByDefaultFlickManager(String docId) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('levels_task')
          .where('levels_ID', isEqualTo: docId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var docSnapshot = querySnapshot.docs.first;
        String videoUrl = docSnapshot['video_url'];
          byDefaultFlickManager?.dispose();
        byDefaultFlickManager = FlickManager(
          videoPlayerController: VideoPlayerController.network(videoUrl),
        );
        notifyListeners();
      } else {
        print('No documents found in Firestore');
      }
    } catch (e) {
      print('Failed to fetch video URL: $e');
    }
  }

  Future<void> initializeFlickManager({String? url, String? levelTaskDocID}) async {
    if (url != null && url.isNotEmpty) {
      flickManager?.dispose();
      byDefaultFlickManager = null;
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(url),
      );
      notifyListeners();

      bool isWatched = await isTaskWatched(FirebaseAuth.instance.currentUser!.uid, levelTaskDocID!);

      if (!isWatched) {
        try {
          CollectionReference collectionRef = FirebaseFirestore.instance.collection("user_task_progress");
          await collectionRef.doc().set({
            "status": "isWatched",
            "userID": FirebaseAuth.instance.currentUser!.uid,
            "task_id": levelTaskDocID,
            "gems": 30,
            "videoPlayed": url
          });

          print('Video marked as watched.');
        } catch (e) {
          print('Failed to update value: $e');
        }
      }
    }
  }

  Future<bool> isTaskWatched(String userID, String levelTaskDocID) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user_task_progress')
          .where('userID', isEqualTo: userID)
          .where('task_id', isEqualTo: levelTaskDocID)
          .where('status', isEqualTo: 'isWatched')
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error fetching data: $e');
      return false;
    }
  }

  Future<void> loadProgress(String docId) async {
    double progress = await calculateProgressPercentage(FirebaseAuth.instance.currentUser!.uid, docId);
    progressValue = progress;
    notifyListeners();
  }

  Future<double> calculateProgressPercentage(String userID, String docId) async {
    try {
      QuerySnapshot totalTasksSnapshot = await FirebaseFirestore.instance
          .collection('levels_task')
          .where('levels_ID', isEqualTo: docId)
          .get();

      QuerySnapshot completedTasksSnapshot = await FirebaseFirestore.instance
          .collection('user_task_progress')
          .where('userID', isEqualTo: userID)
          .where('status', isEqualTo: 'isWatched')
          .get();

      int totalTasks = totalTasksSnapshot.size;
      int completedTasks = completedTasksSnapshot.docs
          .map((doc) => doc['task_id'])
          .toSet()
          .length;

      double progressPercentage =
          totalTasks > 0 ? completedTasks / totalTasks : 0.0;

      return progressPercentage.clamp(0.0, 1.0); // Ensure value is between 0 and 1
    } catch (e) {
      print('Error calculating progress: $e');
      return 0.0;
    }
  }

  Future<void> sendDataToFirebase(int levelNumber, String status, String giftName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, dynamic> data = {
      'level_number': levelNumber,
      'status': status,
      'gift_name': giftName,
    };

    try {
      await firestore.collection('gifts').add(data);
      print('Data sent successfully!');
    } catch (e) {
      print('Error sending data: $e');
    }
  }

}
