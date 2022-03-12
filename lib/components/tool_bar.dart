import 'package:coursework_two/state/audio_state.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../dialogs/exercise_info_dialog.dart';
import '../models/exercise_model.dart';
import '../state/progress_state.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseState>(builder: (context, exerciseState, child) {
      return Consumer<ProgressState>(builder: (context, progressState, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<SettingsState>(builder: (context, settingsState, child) {
              return Consumer<AudioState>(
                  builder: (context, audioState, child) {
                return IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.home,
                      color: Colors.lightGreen,
                    ),
                    onPressed: () async => await goToHomePage(
                        context,
                        audioState,
                        exerciseState,
                        progressState,
                        settingsState));
              });
            }),
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.angleDoubleLeft,
                  color: exerciseState.isBackwardButtonEnabled
                      ? Colors.blue
                      : Colors.grey,
                ),
                onPressed: exerciseState.isBackwardButtonEnabled
                    ? () => goBackward(exerciseState, progressState)
                    : null),
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.angleDoubleRight,
                  color: exerciseState.isForwardButtonEnabled
                      ? Colors.blue
                      : Colors.grey,
                ),
                onPressed: exerciseState.isForwardButtonEnabled
                    ? () => goForward(exerciseState, progressState)
                    : null),
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.question,
                color: Colors.amber,
              ),
              onPressed: () =>
                  openInformation(exerciseState.currentExerciseModel, context),
            )
          ],
        );
      });
    });
  }

  void openInformation(ExerciseModel exerciseModel, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ExerciseInfoDialog(exerciseModel: exerciseModel));
  }

  Future<void> goToHomePage(
      BuildContext context,
      AudioState audioState,
      ExerciseState exerciseState,
      ProgressState progressState,
      SettingsState settingsState) async {
    await audioState.stopAudio();
    settingsState.audioEnabled = false;
    exerciseState.restart();
    progressState.stop();
    Navigator.pushNamed(context, "/");
  }

  void goForward(ExerciseState exerciseState, ProgressState progressState) {
    progressState.stop();
    exerciseState.goForward();
  }

  void goBackward(ExerciseState exerciseState, ProgressState progressState) {
    progressState.stop();
    exerciseState.goBackward();
  }
}
