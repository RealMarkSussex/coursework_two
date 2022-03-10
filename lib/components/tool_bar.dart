import 'package:coursework_two/state/audio_state.dart';
import 'package:coursework_two/state/exercise_state.dart';
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
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<ProgressState>(builder: (context, progressState, child) {
            return Consumer<AudioState>(builder: (context, audioState, child) {
              return IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.home,
                    color: Colors.lightGreen,
                  ),
                  onPressed: () async => await goToHomePage(
                      context, audioState, exerciseState, progressState));
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
                  ? () => goBackward(exerciseState)
                  : null),
          IconButton(
              icon: FaIcon(
                FontAwesomeIcons.angleDoubleRight,
                color: exerciseState.isForwardButtonEnabled
                    ? Colors.blue
                    : Colors.grey,
              ),
              onPressed: exerciseState.isForwardButtonEnabled
                  ? () => goForward(exerciseState)
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
  }

  void openInformation(ExerciseModel exerciseModel, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ExerciseInfoDialog(exerciseModel: exerciseModel));
  }

  Future<void> goToHomePage(BuildContext context, AudioState audioState,
      ExerciseState exerciseState, ProgressState progressState) async {
    await audioState.stopAudio();
    exerciseState.restart();
    progressState.isPlaying = false;
    progressState.cancelTimer();
    Navigator.pushNamed(context, "/");
  }

  void goForward(ExerciseState exerciseState) {
    exerciseState.goForward();
  }

  void goBackward(ExerciseState exerciseState) {
    exerciseState.goBackward();
  }
}
