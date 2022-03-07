import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursework_two/components/exercise.dart';
import 'package:coursework_two/dialogs/exercise_info_dialog.dart';
import 'package:coursework_two/enums/timer_setting.dart';
import 'package:coursework_two/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/sun_salutations_app_bar.dart';
import '../models/exercise_model.dart';

class ExercisesPage extends StatefulWidget {
  final String exerciseType;
  const ExercisesPage({Key? key, required this.exerciseType}) : super(key: key);

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  int currentExercise = 0;
  int lastExercise = 0;
  Color backwardButtonColor = Colors.grey;
  Color forwardsButtonColor = Colors.blue;
  bool isForwardButtonEnabled = true;
  bool isBackwardButtonEnabled = false;
  Future<List<ExerciseModel>> _future = Future.value([]);

  @override
  void initState() {
    super.initState();
    _future = getExercises();
    if (Provider.of<AppState>(context, listen: false).timerSetting !=
        TimerSetting.noTimer) {
      Timer.periodic(
          Duration(
              seconds: Provider.of<AppState>(context, listen: false)
                  .timerValue), (Timer t) async {
        await goForward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ExerciseModel>>(
        future: _future,
        builder: (BuildContext context,
            AsyncSnapshot<List<ExerciseModel>> snapshot) {
          var data = snapshot.data;
          data ??= [];
          ExerciseModel? exerciseModel;

          if (data.isNotEmpty) {
            lastExercise = data.last.sequence;
            exerciseModel = data
                .firstWhere(((element) => element.sequence == currentExercise));
          }
          return Scaffold(
            appBar: createAppBar(widget.exerciseType, context, goForward),
            body: Column(
              children: [
                exerciseModel != null
                    ? Exercise(exerciseModel: exerciseModel)
                    : const SizedBox.shrink(),
                Consumer<AppState>(builder: (context, settings, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: const FaIcon(
                            FontAwesomeIcons.home,
                            color: Colors.lightGreen,
                          ),
                          onPressed: () async => await goToHomePage(settings)),
                      IconButton(
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(
                            FontAwesomeIcons.angleDoubleLeft,
                            color: backwardButtonColor,
                          ),
                          onPressed: isBackwardButtonEnabled
                              ? () async => await goBackward()
                              : null),
                      IconButton(
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(
                            FontAwesomeIcons.angleDoubleRight,
                            color: forwardsButtonColor,
                          ),
                          onPressed: isForwardButtonEnabled
                              ? () async => await goForward()
                              : null),
                      IconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.question,
                          color: Colors.amber,
                        ),
                        onPressed: () => openInformation(exerciseModel),
                      )
                    ],
                  );
                })
              ],
            ),
          );
        });
  }

  Future<void> goBackward() async {
    if (currentExercise != 0) {
      setState(() {
        currentExercise--;
        backwardButtonColor = Colors.blue;
        isBackwardButtonEnabled = true;
        isForwardButtonEnabled = true;
        forwardsButtonColor = Colors.blue;
      });
    }

    if (currentExercise == 0) {
      setState(() {
        backwardButtonColor = Colors.grey;
        isBackwardButtonEnabled = false;
      });
    }
  }

  Future<void> goToHomePage(AppState settingsState) async {
    Navigator.pushNamed(context, '/');
    await settingsState.stopAudio();
  }

  Future<void> goForward() async {
    if (lastExercise != currentExercise) {
      var isLastExercise = currentExercise + 1 == lastExercise;
      setState(() {
        currentExercise++;
        backwardButtonColor = Colors.blue;
        isBackwardButtonEnabled = true;
        isForwardButtonEnabled = !isLastExercise;
        forwardsButtonColor = isLastExercise ? Colors.grey : Colors.blue;
      });
    }
  }

  void openInformation(ExerciseModel? exerciseModel) {
    if (exerciseModel != null) {
      showDialog(
          context: context,
          builder: (context) =>
              ExerciseInfoDialog(exerciseModel: exerciseModel));
    }
  }

  Future<List<ExerciseModel>> getExercises() async {
    CollectionReference _exercisesRef =
        FirebaseFirestore.instance.collection('exercises');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _exercisesRef
        .orderBy('sequence')
        .where('exerciseType', isEqualTo: widget.exerciseType)
        .get();

    // Get data from docs and convert map to List
    return querySnapshot.docs
        .map(
            (doc) => ExerciseModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
