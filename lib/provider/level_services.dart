import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LevelsProvider with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<QueryDocumentSnapshot> _levelDocs = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  final int _itemsPerPage = 6;

  List<QueryDocumentSnapshot> get levelDocs => _levelDocs;
  bool get isLoading => _isLoading;
  int get currentIndex => _currentIndex;
  int get itemsPerPage => _itemsPerPage;

  LevelsProvider() {
    // Optionally, you can start fetching levels when the provider is initialized
    _fetchLevels();
  }

  // Fetch levels from Firestore and sort by level_num
  Future<void> _fetchLevels() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Fetch the levels ordered by the "level_num" field
      QuerySnapshot snapshot = await _firebaseFirestore
          .collection('levels')
          .orderBy('number', descending: false) // Sort in ascending order
          .get();
          print("**********************************");

       print(snapshot);
        print("**********************************");
      _levelDocs = snapshot.docs;
      _isLoading = false;
       print("**********************************");

       print(_levelDocs.length.toString());
        print("**********************************");
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      // Handle errors if necessary
      if (kDebugMode) {
        print('Error fetching levels: $e');
      }
    }
  }

  // Show the next page of levels
  void showNextLevels() {
    if (_currentIndex + _itemsPerPage < _levelDocs.length) {
      _currentIndex += _itemsPerPage;
      notifyListeners();
    }
  }

  // Show the previous page of levels
  void showPreviousLevels() {
    if (_currentIndex - _itemsPerPage >= 0) {
      _currentIndex -= _itemsPerPage;
      notifyListeners();
    }
  }
}
