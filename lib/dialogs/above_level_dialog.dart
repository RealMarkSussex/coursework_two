import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../pages/exercises_page.dart';
import '../state/exercise_state.dart';
import '../state/page_state.dart';

class AboveLevelDialog extends StatelessWidget {
  final String exerciseType;
  const AboveLevelDialog({Key? key, required this.exerciseType}) : super(key: key);
  static const textSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Row(
          children: const [
            FaIcon(
              FontAwesomeIcons.exclamationTriangle,
              color: Colors.amber,
            ),
            SizedBox(
              width: textSpacing,
            ),
            Text('Above Level'),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Flexible(
                      child: Text(
                          'WARNING: You could be starting an exercise above your skill level.'),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  children: const [
                    Text("Are you sure you want to continue?"),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/'),
                      child: const Text('No'),
                    ),
                    Consumer<PageState>(builder: (context, pageState, child) {
                      return Consumer<ExerciseState>(
                          builder: (context, exerciseState, child) {
                        return TextButton(
                          onPressed: () =>
                              openExercises(context, exerciseState, pageState),
                          child: const Text('Yes'),
                        );
                      });
                    }),
                  ],
                )
              ],
            ),
          ),
        ]);
  }

  void openExercises(
      BuildContext context, ExerciseState exerciseState, PageState pageState) {
    exerciseState.exerciseType = exerciseType;
    pageState.isOnExercisePage = true;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const ExercisesPage();
    }));
  }
}
