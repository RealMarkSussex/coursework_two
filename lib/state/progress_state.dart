import 'dart:async';

import 'package:flutter/material.dart';

class ProgressState extends ChangeNotifier {
  Timer _delayTimer = Timer(const Duration(seconds: 0), () {});
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;
  Timer get delayTimer => _delayTimer;

  set delayTimer(Timer value) {
    _delayTimer = value;
    notifyListeners();
  }

  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  void cancelTimer() {
    _delayTimer.cancel();
  }
}
