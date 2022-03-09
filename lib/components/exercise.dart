import 'package:coursework_two/models/exercise_model.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Exercise extends StatelessWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseState>(builder: (context, exerciseState, child) {
      var exerciseModel = exerciseState.currentExerciseModel;
      return Expanded(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                      : SizedBox(),
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
  }
}
