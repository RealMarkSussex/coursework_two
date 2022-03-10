import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioState extends ChangeNotifier {
  final AudioCache _audioPlayer = AudioCache(fixedPlayer: AudioPlayer());

  AudioCache get audioPlayer => _audioPlayer;

  Future<void> playAudio(String fileName) async {
    await _audioPlayer.play(fileName);
    notifyListeners();

  }

  Future<void> stopAudio() async {
    await _audioPlayer.fixedPlayer!.stop();
    notifyListeners();
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.fixedPlayer!.setVolume(volume);
    notifyListeners();
  }
}
