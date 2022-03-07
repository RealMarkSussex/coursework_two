import 'package:audioplayers/audioplayers.dart';
import 'package:coursework_two/state/appState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Consumer<AppState>(builder: (context, settings, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Text("Enable audio"),
                Switch(
                    value: settings.audioEnabled,
                    onChanged: settings.toggleAudioPreference)
              ],
            ),
            Row(
              children: [
                const Text("Change Volume"),
                Slider(value: settings.volume, onChanged: settings.changeVolume)
              ],
            )
          ],
        );
      })
    ]);
  }
}
