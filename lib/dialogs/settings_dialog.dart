import 'package:coursework_two/dialogs/set_info_dialog.dart';
import 'package:coursework_two/dialogs/timer_info_dialog.dart';
import 'package:coursework_two/enums/set_setting.dart';
import 'package:coursework_two/enums/timer_setting.dart';
import 'package:coursework_two/services/firebase_service.dart';
import 'package:coursework_two/state/audio_state.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../enums/level.dart';

class SettingsDialog extends StatelessWidget {
  static const paragraphSpacing = 20.0;
  static const textSpacing = 20.0;

  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Consumer<AudioState>(builder: (context, audioState, child) {
        return Consumer<SettingsState>(
            builder: (context, settingsState, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text("Enable audio"),
                    const SizedBox(
                      width: SettingsDialog.textSpacing,
                    ),
                    Expanded(
                      child: Switch(
                          value: settingsState.audioEnabled,
                          onChanged: (value) => changeAudioPreference(
                              settingsState, audioState, context)),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Enable breathing cues"),
                    const SizedBox(
                      width: SettingsDialog.textSpacing,
                    ),
                    Expanded(
                      child: Switch(
                          value: settingsState.breathingCuesEnabled,
                          onChanged: (value) =>
                              settingsState.breathingCuesEnabled = true),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Change Volume"),
                    const SizedBox(
                      width: SettingsDialog.textSpacing,
                    ),
                    Expanded(
                      child: Slider(
                          value: settingsState.volume,
                          onChanged: (value) =>
                              changeVolume(settingsState, audioState, value)),
                    )
                  ],
                ),
                Row(children: [
                  const Text("Adjust tempo"),
                  const SizedBox(
                    width: SettingsDialog.textSpacing,
                  ),
                  Expanded(
                    child: DropdownButton<TimerSetting>(
                        value: settingsState.timerSetting,
                        items: settingsState.timerSetting
                            .toList()
                            .map((timerSettingModel) =>
                                DropdownMenuItem<TimerSetting>(
                                  child: Text(timerSettingModel.description),
                                  value: timerSettingModel.timerSetting,
                                ))
                            .toList(),
                        onChanged: (value) =>
                            settingsState.timerSetting = value!),
                  ),
                  IconButton(
                    onPressed: () => openTimerInfo(context),
                    icon: const FaIcon(
                      FontAwesomeIcons.infoCircle,
                      color: Colors.amber,
                    ),
                  )
                ]),
                Row(
                  children: [
                    const Text("Change number of sets"),
                    const SizedBox(
                      width: SettingsDialog.textSpacing,
                    ),
                    Expanded(
                      child: DropdownButton<SetSetting>(
                          value: settingsState.setSetting,
                          items: settingsState.setSetting
                              .toList()
                              .map((setSettingModel) =>
                                  DropdownMenuItem<SetSetting>(
                                    child: Text(setSettingModel.description),
                                    value: setSettingModel.setSetting,
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              settingsState.setSetting = value!),
                    ),
                    IconButton(
                      onPressed: () => openSetInfo(context),
                      icon: const FaIcon(
                        FontAwesomeIcons.infoCircle,
                        color: Colors.amber,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Change level"),
                    const SizedBox(
                      width: SettingsDialog.textSpacing,
                    ),
                    Expanded(
                      child: DropdownButton<Level>(
                          value: settingsState.level,
                          items: settingsState.level
                              .toList()
                              .map((levelModel) => DropdownMenuItem<Level>(
                                    child: Text(levelModel.description),
                                    value: levelModel.level,
                                  ))
                              .toList(),
                          onChanged: (value) async =>
                              await changeLevel(settingsState, value!)),
                    ),
                  ],
                )
              ],
            ),
          );
        });
      })
    ]);
  }

  void changeVolume(
      SettingsState settingsState, AudioState audioState, double value) {
    settingsState.volume = value;
    audioState.setVolume(value);
  }

  Future<void> changeLevel(SettingsState settingsState, Level value) async {
    settingsState.level = value;
    await FirebaseService().storeLevelForUser(value);
  }

  void changeAudioPreference(SettingsState settingsState, AudioState audioState,
      BuildContext context) {
    var audioEnabled = !settingsState.audioEnabled;
    settingsState.audioEnabled = audioEnabled;
    var exerciseModel =
        Provider.of<ExerciseState>(context, listen: false).currentExerciseModel;
    if (!audioEnabled) {
      audioState.stopAudio();
    } else {
      audioState.playAudio('audio/${exerciseModel.audio}');
    }
  }

  void openTimerInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const TimerInfoDialog();
        });
  }

  void openSetInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SetInfoDialog();
        });
  }
}
