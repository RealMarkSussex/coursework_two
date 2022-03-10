import 'dart:async';

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
                icon: const FaIcon(
                  FontAwesomeIcons.stop,
                  color: Colors.red,
                ),
                onPressed: () => onStopPressed(progressState)),
            IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.play,
                  color: Colors.green,
                ),
                onPressed: () =>
                    onPlayPressed(progressState, exerciseState, context)),
          ],
        );
      });
    });
  }

  void onPlayPressed(ProgressState progressState, ExerciseState exerciseState,
      BuildContext context) {
    progressState.isPlaying = true;

    var delayTime = Provider.of<SettingsState>(context, listen: false)
            .timerSetting
            .toInt() -
        15;
    progressState.delayTimer = Timer.periodic(Duration(seconds: (delayTime)),
        (Timer t) => {exerciseState.goForward()});
  }

  void onStopPressed(ProgressState progressState) {
    progressState.isPlaying = false;
    progressState.cancelTimer();
  }
}
