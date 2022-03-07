import 'package:coursework_two/models/exercise_model.dart';
import 'package:coursework_two/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Exercise extends StatelessWidget {
  final ExerciseModel exerciseModel;
  const Exercise({Key? key, required this.exerciseModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: Provider.of<AppState>(context, listen: false)
            .playAudio(exerciseModel.audio),
        builder: (context, snapshot) {
          return Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InteractiveViewer(
                          panEnabled: false,
                          boundaryMargin: const EdgeInsets.all(100),
                          minScale: 0.5,
                          maxScale: 2,
                          child: Image(
                            image: AssetImage(
                                'assets/images/${exerciseModel.image}'),
                          ),
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
