import 'package:coursework_two/models/exerciseModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExerciseInfoDialog extends StatelessWidget {
  final ExerciseModel exerciseModel;
  const ExerciseInfoDialog({Key? key, required this.exerciseModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textSpacing = 20.0;
    const paragraphSpacing = 20.0;
    return SimpleDialog(children: [
      !exerciseModel.isInfoEmpty()
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  exerciseModel.breathing != "-"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              const FaIcon(
                                FontAwesomeIcons.lungs,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(
                                width: textSpacing,
                              ),
                              Flexible(child: Text(exerciseModel.breathing))
                            ])
                      : const SizedBox.shrink(),
                  const SizedBox(height: paragraphSpacing),
                  exerciseModel.precaution != "-"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              const FaIcon(
                                FontAwesomeIcons.exclamationTriangle,
                                color: Colors.orange,
                              ),
                              const SizedBox(
                                width: textSpacing,
                              ),
                              Flexible(child: Text(exerciseModel.precaution))
                            ])
                      : const SizedBox.shrink()
                ],
              ),
            )
          : const Text("No extra info")
    ]);
  }
}
