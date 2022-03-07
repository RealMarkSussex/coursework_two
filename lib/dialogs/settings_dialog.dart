import 'package:audioplayers/audioplayers.dart';
import 'package:coursework_two/enums/timer_setting.dart';
import 'package:coursework_two/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  final Function callback;
  const SettingsDialog({Key? key, required this.callback}) : super(key: key);
  static const paragraphSpacing = 20.0;
  static const textSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Consumer<AppState>(builder: (context, settings, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Text("Enable audio"),
                  const SizedBox(
                    width: textSpacing,
                  ),
                  Expanded(
                    child: Switch(
                        value: settings.audioEnabled,
                        onChanged: settings.toggleAudioPreference),
                  )
                ],
              ),
              Row(
                children: [
                  const Text("Change Volume"),
                  const SizedBox(
                    width: textSpacing,
                  ),
                  Expanded(
                    child: Slider(
                        value: settings.volume,
                        onChanged: settings.changeVolume),
                  )
                ],
              ),
              Row(children: [
                const Text("Adjust tempo"),
                const SizedBox(
                  width: textSpacing,
                ),
                Expanded(
                  child: DropdownButton<TimerSetting>(
                      value: settings.timerSetting,
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
                      onChanged: (e) =>
                          settings.updateTimerSetting(e, callback)),
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
      })
    ]);
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
                  const SizedBox(height: paragraphSpacing),
                  const Text(
                      'This is for automatically scrolling through the exercises without lifting a finger.'),
                  const SizedBox(height: paragraphSpacing),
                  const Align(
                    child: Text(
                        'By default this is set to no timer meaning scrolling won\'t happen automatically.'),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: paragraphSpacing),
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
