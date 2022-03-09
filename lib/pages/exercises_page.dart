import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursework_two/components/exercise.dart';
import 'package:coursework_two/components/tool_bar.dart';
import 'package:coursework_two/dialogs/exercise_info_dialog.dart';
import 'package:coursework_two/enums/timer_setting.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import '../components/sun_salutations_app_bar.dart';
import '../models/exercise_model.dart';
import '../state/exercise_state.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({Key? key}) : super(key: key);

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage>
    with TickerProviderStateMixin {
  Timer _delayTimer = Timer(const Duration(seconds: 0), () {});
  late AnimationController anim =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..forward();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsState>(builder: (context, settingsState, child) {
      return Consumer<ExerciseState>(builder: (context, exerciseState, child) {
        return Scaffold(
          appBar: createAppBar(exerciseState.exerciseType, context),
          body: Column(
            children: [
              const Exercise(),
              settingsState.timerSetting != TimerSetting.noTimer
                  ? LinearProgressIndicator(
                      value: anim.value,
                      semanticsLabel: 'Linear progress indicator',
                    )
                  : const SizedBox.shrink(),
              const ToolBar()
            ],
          ),
        );
      });
    });
  }
}
