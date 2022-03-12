import 'package:audioplayers/audioplayers.dart';
import 'package:coursework_two/state/audio_state.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:coursework_two/state/page_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/settings_state.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseState>(builder: (context, exerciseState, child) {
      var exerciseModel = exerciseState.currentExerciseModel;
      return FutureBuilder<void>(
          future: playAudio(),
          builder: (context, snapshot) {
            return Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          exerciseModel.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InteractiveViewer(
                            panEnabled: false,
                            boundaryMargin: const EdgeInsets.all(100),
                            minScale: 0.5,
                            maxScale: 2,
                            child: exerciseModel.image.isNotEmpty
                                ? Image(
                                    image: AssetImage(
                                        'assets/images/${exerciseModel.image}'),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                exerciseModel.process,
                                textAlign: TextAlign.justify,
                                softWrap: true,
                                textScaleFactor: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            );
          });
    });
  }

  Future<void> playAudio() async {
    var settingsState = Provider.of<SettingsState>(context, listen: false);
    var exerciseState = Provider.of<ExerciseState>(context, listen: false);
    var audioState = Provider.of<AudioState>(context, listen: false);
    var pageState = Provider.of<PageState>(context, listen: false);

    if (settingsState.audioEnabled && pageState.isOnExercisePage) {
      if (exerciseState.currentExerciseModel.audio == "-") {
        await audioState.audioPlayer.play('audio/noSound.mp3');
      } else {
        await audioState.audioPlayer
            .play('audio/${exerciseState.currentExerciseModel.audio}');
      }
    }
  }
}
