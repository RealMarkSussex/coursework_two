import 'package:coursework_two/state/audio_state.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:coursework_two/state/page_state.dart';
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
            Consumer<PageState>(builder: (context, pageState, child) {
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
                        pageState));
              });
            }),
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.angleDoubleLeft,
                  color: !exerciseState.isFirstExercise
                      ? Colors.blue
                      : Colors.grey,
                ),
                onPressed: !exerciseState.isFirstExercise
                    ? () => goBackward(exerciseState, progressState)
                    : null),
            IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.angleDoubleRight,
                  color: !exerciseState.isLastExercise
                      ? Colors.blue
                      : Colors.grey,
                ),
                onPressed: !exerciseState.isLastExercise
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
      PageState pageState) async {
    await audioState.stopAudio();
    pageState.isOnExercisePage = false;
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
