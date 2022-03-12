import 'dart:async';

import 'package:flutter/material.dart';

class ProgressState extends ChangeNotifier {
  Timer _delayTimer = Timer(const Duration(seconds: 0), () {});
  bool _isPlaying = false;
  int _setsLeft = 0;

  bool get isPlaying => _isPlaying;
  Timer get delayTimer => _delayTimer;
  int get setsLeft => _setsLeft;

  set delayTimer(Timer value) {
    _delayTimer = value;
    notifyListeners();
  }

  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  set setsLeft(int value) {
    _setsLeft = value;
    notifyListeners();
  }
  
  void stop() {
    _delayTimer.cancel();
    _isPlaying = false;
    _setsLeft = 0;
    notifyListeners();
  }
}
