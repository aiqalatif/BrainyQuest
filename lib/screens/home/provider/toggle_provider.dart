import 'package:flutter/material.dart';

class OpenProvider with ChangeNotifier {
  bool _open = false;

  bool get isOpen => _open;

  void toggleOpen() {
    _open = !_open;
    notifyListeners();
  }
}
