import 'package:cloud_firestore/cloud_firestore.dart';

class UserGift {
  final int levelNumber;
  final String status;
  final String giftName;

  UserGift({
    required this.levelNumber,
    required this.status,
    required this.giftName,
  });

  // Convert a UserGift instance into a Map
  Map<String, dynamic> toMap() {
    return {
      'level_number': levelNumber,
      'status': status,
      'gift_name': giftName,
    };
  }

  // Create a UserGift instance from a Map
  factory UserGift.fromMap(Map<String, dynamic> map) {
    return UserGift(
      levelNumber: map['level_number'] ?? 0,
      status: map['status'] ?? '',
      giftName: map['gift_name'] ?? '',
    );
  }

  // Create a UserGift instance from a Firestore DocumentSnapshot
  factory UserGift.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserGift.fromMap(doc.data() as Map<String, dynamic>);
  }
}
