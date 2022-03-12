import 'package:flutter/material.dart';

class PageState extends ChangeNotifier {
  bool _isOnExercisePage = false;

  bool get isOnExercisePage => _isOnExercisePage;

  set isOnExercisePage(bool value) {
    _isOnExercisePage = value;
    notifyListeners();
  }
}
