import 'package:coursework_two/components/exercise.dart';
import 'package:coursework_two/components/progress_bar.dart';
import 'package:coursework_two/components/tool_bar.dart';
import 'package:coursework_two/enums/timer_setting.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/sun_salutations_app_bar.dart';
import '../components/top_bar.dart';
import '../state/exercise_state.dart';
import '../state/progress_state.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({Key? key}) : super(key: key);

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseState>(builder: (context, exerciseState, child) {
      return Scaffold(
        appBar: createAppBar(exerciseState.exerciseType, context),
        body: Consumer<SettingsState>(builder: (context, settingsState, child) {
          return Consumer<ProgressState>(
              builder: (context, progressState, child) {
            return Column(
              children: [
                settingsState.timerSetting != TimerSetting.noTimer
                    ? const TopBar()
                    : const SizedBox.shrink(),
                const Exercise(),
                settingsState.timerSetting != TimerSetting.noTimer &&
                        progressState.isPlaying &&
                        exerciseState.currentExercise !=
                            exerciseState.lastExercise
                    ? const ProgressBar()
                    : const SizedBox.shrink(),
                const ToolBar(),
              ],
            );
          });
        }),
      );
    });
  }
}
