import 'package:cloud_firestore/cloud_firestore.dart';

class UserTaskProgress {
  String status;
  String userID;
  String taskId;
  int gems;
  String videoPlayed;

  UserTaskProgress({
    required this.status,
    required this.userID,
    required this.taskId,
    required this.gems,
    required this.videoPlayed,
  });

  // Convert a UserTaskProgress instance into a Map
  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'userID': userID,
      'task_id': taskId,
      'gems': gems,
      'videoPlayed': videoPlayed,
    };
  }

  // Create a UserTaskProgress instance from a Map
  factory UserTaskProgress.fromMap(Map<String, dynamic> map) {
    return UserTaskProgress(
      status: map['status'],
      userID: map['userID'],
      taskId: map['task_id'],
      gems: map['gems'],
      videoPlayed: map['videoPlayed'],
    );
  }

  // Optionally, you can also add a method to convert from a Firestore document snapshot
  factory UserTaskProgress.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserTaskProgress.fromMap(doc.data() as Map<String, dynamic>);
  }
}
