import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:coursework_two/enums/timer_setting.dart';
import 'package:flutter/cupertino.dart';

class AppState extends ChangeNotifier {
  AudioCache audioCache = AudioCache(fixedPlayer: AudioPlayer());
  bool audioEnabled = true;
  double volume = 0.5;
  TimerSetting timerSetting = TimerSetting.noTimer;
  int timerValue = 0;
  Timer delayTimer = Timer(const Duration(seconds: 0), () {});
  Future<void> init() async {
    await audioCache.fixedPlayer!.setVolume(volume);
    notifyListeners();
  }

  Future<void> changeVolume(double volume) async {
    this.volume = volume;
    await audioCache.fixedPlayer!.setVolume(volume);

    notifyListeners();
  }

  Future<void> playAudio(String fileName) async {
    if (audioEnabled && fileName.isNotEmpty) {
      await audioCache.fixedPlayer!.stop();
      Future.delayed(const Duration(milliseconds: 500), () async {
        await audioCache.play("audio/$fileName");
      });
    }

    notifyListeners();
  }

  Future<void> stopAudio() async {
    if (audioEnabled) {
      await audioCache.fixedPlayer!.stop();
    }
    notifyListeners();
  }

  Future<void> toggleAudioPreference(bool newPreference) async {
    await audioCache.fixedPlayer!.stop();
    audioEnabled = newPreference;

    notifyListeners();
  }

  void updateTimerSetting(TimerSetting? timerSetting, Function callback) {
    if (timerSetting != null) {
      this.timerSetting = timerSetting;
      timerValue = timerSetting.toNumber();
      delayTimer.cancel();
      if (timerSetting != TimerSetting.noTimer) {
        delayTimer =
            Timer.periodic(Duration(seconds: timerValue), (Timer t) async {
          await callback();
        });
      }
    }

    notifyListeners();
  }
}
