import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursework_two/components/exercise.dart';
import 'package:coursework_two/dialogs/exerciseInfoDialog.dart';
import 'package:coursework_two/state/settingsState.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/sunSalutationsAppBar.dart';
import '../models/exerciseModel.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ExerciseModel>>(
        future: getExercises(),
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
            appBar: createAppBar(widget.exerciseType, context),
            body: Column(
              children: [
                exerciseModel != null
                    ? Exercise(exerciseModel: exerciseModel)
                    : const SizedBox.shrink(),
                Consumer<SettingsState>(builder: (context, settings, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: const FaIcon(
                            FontAwesomeIcons.home,
                            color: Colors.lightGreen,
                          ),
                          onPressed: goToHomePage),
                      IconButton(
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(
                            FontAwesomeIcons.angleDoubleLeft,
                            color: backwardButtonColor,
                          ),
                          onPressed: isBackwardButtonEnabled
                              ? () => goBackward(settings)
                              : null),
                      IconButton(
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: FaIcon(
                            FontAwesomeIcons.angleDoubleRight,
                            color: forwardsButtonColor,
                          ),
                          onPressed: isForwardButtonEnabled
                              ? () => goForward(settings)
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

  Future<void> goBackward(SettingsState settingsState) async {
    if (currentExercise != 0) {
      setState(() {
        currentExercise--;
        backwardButtonColor = Colors.blue;
        isBackwardButtonEnabled = true;
        isForwardButtonEnabled = true;
        forwardsButtonColor = Colors.blue;
      });
      await settingsState.playAudio('introduction.mp3');
    }

    if (currentExercise == 0) {
      setState(() {
        backwardButtonColor = Colors.grey;
        isBackwardButtonEnabled = false;
      });
    }
  }

  void goToHomePage() {
    Navigator.pushNamed(context, '/');
  }

  Future<void> goForward(SettingsState settingsState) async {
    if (lastExercise != currentExercise) {
      var isLastExercise = currentExercise + 1 == lastExercise;
      setState(() {
        currentExercise++;
        backwardButtonColor = Colors.blue;
        isBackwardButtonEnabled = true;
        isForwardButtonEnabled = !isLastExercise;
        forwardsButtonColor = isLastExercise ? Colors.grey : Colors.blue;
      });
      await settingsState.playAudio('introduction.mp3');
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
