import 'dart:async';

import 'package:coursework_two/components/exercise.dart';
import 'package:coursework_two/components/progress_bar.dart';
import 'package:coursework_two/components/tool_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/sun_salutations_app_bar.dart';
import '../state/exercise_state.dart';

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
        body: Column(
          children: const [Exercise(), ProgressBar(), ToolBar()],
        ),
      );
    });
  }

  void goForward(ExerciseState exerciseState) {
    exerciseState.goForward();
  }
}
