import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brain_master/utils/custom_toast_message.dart';

class ProfileProvider with ChangeNotifier {
  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  void setImageUrl(String? url) {
    _imageUrl = url;
    notifyListeners();
  }

  Future<void> submitData(String name, String email) async {
    if (_imageUrl != null) {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;

        await FirebaseFirestore.instance.collection('users').doc(userId).update(
          {
            "email": email.trim(),
            "userName": name.trim(),
            'imageUrl': _imageUrl,
          },
        );
        CustomToast.showToast("Congratulations", "Data uploaded successfully.");
      } catch (e) {
        CustomToast.showToast("Error uploading data:", " $e");
      }
    } else {
      CustomToast.showToast("Dear User!", "Please pick an image first.");
    }
  }
}
