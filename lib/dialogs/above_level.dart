import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../pages/exercises_page.dart';
import '../state/exercise_state.dart';
import '../state/page_state.dart';

class AboveLevel extends StatelessWidget {
  final String exerciseType;
  const AboveLevel({Key? key, required this.exerciseType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Above Level'),
      content: Expanded(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: const [
                  FaIcon(
                    FontAwesomeIcons.exclamationTriangle,
                    color: Colors.amber,
                  ),
                  Flexible(
                    child: Text(
                        'WARNING: You could be starting an exercise above your skill level.'),
                  )
                ],
              ),
            ),
            const Text("Are you sure you want to continue?")
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/'),
          child: const Text('No'),
        ),
        Consumer<PageState>(builder: (context, pageState, child) {
          return Consumer<ExerciseState>(
              builder: (context, exerciseState, child) {
            return TextButton(
              onPressed: () => openExercises(context, exerciseState, pageState),
              child: const Text('Yes'),
            );
          });
        }),
      ],
    );
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
