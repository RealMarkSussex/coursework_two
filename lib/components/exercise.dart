import 'package:coursework_two/components/interactive_image.dart';
import 'package:coursework_two/state/audio_state.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:coursework_two/state/page_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/opacity_state.dart';
import '../state/settings_state.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  static const headingFontSize = 20.0;

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
                    Center(
                      child: Consumer<OpacityState>(
                          builder: (context, opacityState, child) {
                        return Consumer<SettingsState>(
                            builder: (context, settingsState, child) {
                          return settingsState.breathingCuesEnabled
                              ? AnimatedOpacity(
                                  opacity: opacityState.opacity,
                                  duration: const Duration(seconds: 5),
                                  child: Text(
                                    exerciseModel.breathing,
                                    style: const TextStyle(
                                        fontSize: headingFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : const SizedBox.shrink();
                        });
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          exerciseModel.name,
                          style: const TextStyle(
                              fontSize: headingFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InteractiveViewer(
                        panEnabled: false,
                        boundaryMargin: const EdgeInsets.all(20.0),
                        minScale: 0.1,
                        maxScale: 1.6,
                        child: exerciseModel.image.isNotEmpty
                            ? InteractiveImage(
                                image: Image(
                                image: AssetImage(
                                    'assets/images/${exerciseModel.image}'),
                              ))
                            : const SizedBox.shrink(),
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
    changeOpacity();

    if (settingsState.audioEnabled && pageState.isOnExercisePage) {
      if (exerciseState.currentExerciseModel.audio == "-") {
        await audioState.audioPlayer.play('audio/noSound.mp3');
      } else {
        await audioState.audioPlayer
            .play('audio/${exerciseState.currentExerciseModel.audio}');
      }
    }
  }

  void changeOpacity() {
    Future.delayed(const Duration(seconds: 5), () {
      Provider.of<OpacityState>(context, listen: false).opacity = 0.0;
    });
  }
}
