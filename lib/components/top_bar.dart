import 'dart:async';

import 'package:coursework_two/enums/set_setting.dart';
import 'package:coursework_two/enums/timer_setting.dart';
import 'package:coursework_two/state/progress_state.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../state/exercise_state.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseState>(builder: (context, exerciseState, child) {
      return Consumer<ProgressState>(builder: (context, progressState, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.stop,
                  color: progressState.isPlaying ? Colors.red : Colors.grey,
                ),
                onPressed: () => progressState.isPlaying
                    ? onStopPressed(progressState)
                    : null),
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.play,
                  color: !progressState.isPlaying ? Colors.green : Colors.grey,
                ),
                onPressed: () => !progressState.isPlaying
                    ? onPlayPressed(progressState, exerciseState, context)
                    : null),
          ],
        );
      });
    });
  }

  void onPlayPressed(ProgressState progressState, ExerciseState exerciseState,
      BuildContext context) {
    progressState.isPlaying = true;
    var settingsState = Provider.of<SettingsState>(context, listen: false);
    var delayTime = settingsState.timerSetting.toInt();
    progressState.setsLeft = settingsState.setSetting.toInt();
    progressState.delayTimer = Timer.periodic(Duration(seconds: (delayTime)),
        (Timer t) => {timerFunction(exerciseState, progressState)});
  }

  void onStopPressed(ProgressState progressState) {
    progressState.stop();
  }

  void timerFunction(ExerciseState exerciseState, ProgressState progressState) {
    if (!exerciseState.isLastExercise) {
      exerciseState.goForward();
    } else if (progressState.setsLeft > 0) {
      exerciseState.restart();
      progressState.setsLeft--;
    } else {
      progressState.stop();
    }
  }
}
