import 'package:coursework_two/enums/level.dart';
import 'package:coursework_two/enums/set_setting.dart';
import 'package:coursework_two/enums/timer_setting.dart';
import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  bool _audioEnabled = true;
  double _volume = 0.5;
  TimerSetting _timerSetting = TimerSetting.noTimer;
  SetSetting _setSetting = SetSetting.oneSet;
  Level _level = Level.newToYoga;
  bool _breathingCuesEnabled = false;

  bool get audioEnabled => _audioEnabled;
  bool get breathingCuesEnabled => _breathingCuesEnabled;
  double get volume => _volume;
  TimerSetting get timerSetting => _timerSetting;
  SetSetting get setSetting => _setSetting;
  Level get level => _level;

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

  set setSetting(SetSetting value) {
    _setSetting = value;
    notifyListeners();
  }

  set level(Level value) {
    _level = value;
    notifyListeners();
  }

  set breathingCuesEnabled(bool value) {
    _breathingCuesEnabled = value;
    notifyListeners();
  }
}
