import 'package:flutter/material.dart';

class OpacityState extends ChangeNotifier {
  double _opacity = 1.0;

  double get opacity => _opacity;

  set opacity(double value) {
    _opacity = value;
    notifyListeners();
  }
}
