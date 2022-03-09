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

class _ExercisesPageState extends State<ExercisesPage>
    with TickerProviderStateMixin {
  int currentExercise = 0;
  int lastExercise = 0;

  Color backwardButtonColor = Colors.grey;
  Color forwardsButtonColor = Colors.blue;
  bool isForwardButtonEnabled = true;
  bool isBackwardButtonEnabled = false;
  TimerSetting timerSetting = TimerSetting.noTimer;
  Future<List<ExerciseModel>> _future = Future.value([]);
  List<ExerciseModel> exerciseModels = [];
  Timer _delayTimer = Timer(const Duration(seconds: 0), () {});
  late AnimationController anim =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..forward();

  @override
  void initState() {
    _future = getExercises();

    super.initState();
  }

  void initTimers(TimerSetting? timerSetting, AppState settingsState) {
    if (timerSetting != null) {
      var timerValue = timerSetting.toInt();
      setState(() {
        this.timerSetting = timerSetting;
        anim = AnimationController(
          vsync: this,
          duration: Duration(seconds: timerValue),
        )..addListener(() {
            setState(() {});
          });
        anim.repeat();
        _delayTimer = Timer.periodic(
            Duration(seconds: (timerSetting.toInt())),
            (Timer t) async => {
                  if (timerValue != 0 && timerSetting != TimerSetting.noTimer)
                    {await goForward(settingsState)}
                });
      });
    }
  }

  void cancelTimers() {
    setState(() {
      _delayTimer.cancel();
      anim.dispose();
    });
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
            appBar: createAppBar(widget.exerciseType, context, updateTimer),
            body: Column(
              children: [
                exerciseModel != null
                    ? Exercise(exerciseModel: exerciseModel)
                    : const SizedBox.shrink(),
                timerSetting != TimerSetting.noTimer
                    ? LinearProgressIndicator(
                        value: anim.value,
                        semanticsLabel: 'Linear progress indicator',
                      )
                    : const SizedBox.shrink(),
                Consumer<AppState>(builder: (context, settings, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.home,
                            color: Colors.lightGreen,
                          ),
                          onPressed: () async => await goToHomePage(settings)),
                      IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.angleDoubleLeft,
                            color: backwardButtonColor,
                          ),
                          onPressed: isBackwardButtonEnabled
                              ? () async => await goBackward(settings)
                              : null),
                      IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.angleDoubleRight,
                            color: forwardsButtonColor,
                          ),
                          onPressed: isForwardButtonEnabled
                              ? () async => await goForward(settings)
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

  Future<void> goBackward(AppState settingsState) async {
    await settingsState.stopAudio();
    cancelTimers();
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
    await settingsState.playAudio(exerciseModels
        .firstWhere((element) => element.sequence == currentExercise)
        .audio);
    initTimers(timerSetting, settingsState);
  }

  Future<void> goToHomePage(AppState settingsState) async {
    cancelTimers();
    Navigator.pushNamed(context, '/');
    await settingsState.stopAudio();
  }

  Future<void> goForward(AppState settingsState) async {
    await settingsState.stopAudio();
    cancelTimers();
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
    await settingsState.playAudio(exerciseModels
        .firstWhere((element) => element.sequence == currentExercise)
        .audio);
    initTimers(timerSetting, settingsState);
  }

  void updateTimer(TimerSetting? timerSetting, AppState settingsState) {
    cancelTimers();
    initTimers(timerSetting, settingsState);
  }

  void openInformation(ExerciseModel? exerciseModel) {
    cancelTimers();
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
    exerciseModels = querySnapshot.docs
        .map(
            (doc) => ExerciseModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return exerciseModels;
  }
}
