import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  List<DocumentSnapshot> _videos = [];
  List<DocumentSnapshot> get videos => _videos;

  VideoTaskProvider() {
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('levels_task')
        .where('levels_ID', isEqualTo: 'your_doc_id_here') // Use a way to set or get this ID dynamically
        .get();
    _videos = snapshot.docs;
    notifyListeners();
  }
}

