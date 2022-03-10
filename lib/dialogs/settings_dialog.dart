import 'package:coursework_two/enums/timer_setting.dart';
import 'package:coursework_two/state/audio_state.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
                        items: const [
                          DropdownMenuItem<TimerSetting>(
                            child: Text("No timer"),
                            value: TimerSetting.noTimer,
                          ),
                          DropdownMenuItem<TimerSetting>(
                            child: Text("20 seconds"),
                            value: TimerSetting.twentySeconds,
                          ),
                          DropdownMenuItem<TimerSetting>(
                            child: Text("40 seconds"),
                            value: TimerSetting.fourtySeconds,
                          ),
                          DropdownMenuItem<TimerSetting>(
                            child: Text("1 minute"),
                            value: TimerSetting.oneMinute,
                          ),
                          DropdownMenuItem<TimerSetting>(
                            child: Text("2 minutes"),
                            value: TimerSetting.twoMinutes,
                          )
                        ],
                        onChanged: (value) =>
                            settingsState.timerSetting = value!),
                  ),
                  IconButton(
                    onPressed: () => openHelp(context),
                    icon: const FaIcon(
                      FontAwesomeIcons.infoCircle,
                      color: Colors.amber,
                    ),
                  )
                ])
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

  void openHelp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Timer Settings Help'),
                  const SizedBox(height: SettingsDialog.paragraphSpacing),
                  const Text(
                      'This is for automatically scrolling through the exercises without lifting a finger.'),
                  const SizedBox(height: SettingsDialog.paragraphSpacing),
                  const Align(
                    child: Text(
                        'By default this is set to no timer meaning scrolling won\'t happen automatically.'),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: SettingsDialog.paragraphSpacing),
                  const Text(
                      'If you decide to go at 20 seconds speed you will not have audio instructions.'),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            )
          ]);
        });
  }
}
