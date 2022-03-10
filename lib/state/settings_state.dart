import 'package:coursework_two/enums/timer_setting.dart';
import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  bool _audioEnabled = true;
  double _volume = 0.5;
  TimerSetting _timerSetting = TimerSetting.noTimer;

  bool get audioEnabled => _audioEnabled;
  double get volume => _volume;
  TimerSetting get timerSetting => _timerSetting;

  set volume(double value) {
    _volume = value;
    notifyListeners();
  }

  set audioEnabled(bool value) {
    _audioEnabled = value;
    notifyListeners();
  }

  set timerSetting(TimerSetting value) {
    _timerSetting = value;
    notifyListeners();
  }
}
