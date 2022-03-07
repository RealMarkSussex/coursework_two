import 'package:coursework_two/models/exerciseModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExerciseInfoDialog extends StatelessWidget {
  final ExerciseModel exerciseModel;
  static const textSpacing = 20.0;
  static const paragraphSpacing = 20.0;
  const ExerciseInfoDialog({Key? key, required this.exerciseModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      !exerciseModel.isInfoEmpty()
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  generateInfoTab(
                      exerciseModel.breathing,
                      const FaIcon(
                        FontAwesomeIcons.lungs,
                        color: Colors.blueAccent,
                      )),
                  const SizedBox(height: paragraphSpacing),
                  generateInfoTab(
                      exerciseModel.precaution,
                      const FaIcon(
                        FontAwesomeIcons.exclamationTriangle,
                        color: Colors.orange,
                      )),
                  const SizedBox(height: paragraphSpacing),
                  generateInfoTab(
                      exerciseModel.benefits,
                      const FaIcon(
                        FontAwesomeIcons.check,
                        color: Colors.green,
                      )),
                ],
              ),
            )
          : const Text("No extra info")
    ]);
  }

  Widget generateInfoTab(String info, FaIcon icon) {
    return info != "-"
        ? Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            icon,
            const SizedBox(
              width: textSpacing,
            ),
            Flexible(child: Text(info))
          ])
        : const SizedBox.shrink();
  }
}
