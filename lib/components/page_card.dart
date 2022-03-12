import 'package:coursework_two/dialogs/above_level.dart';
import 'package:coursework_two/pages/exercises_page.dart';
import 'package:coursework_two/models/card_info_model.dart';
import 'package:coursework_two/state/exercise_state.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coursework_two/enums/level.dart';
import '../state/page_state.dart';

class PageCard extends StatelessWidget {
  final CardInfoModel cardInfoModel;
  const PageCard({Key? key, required this.cardInfoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const buttonFontSize = 18.0;
    const paragraphFontSize = 16.0;
    const titleFontSize = 20.0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          child: Column(
        children: [
          Image(image: AssetImage('assets/images/${cardInfoModel.image}')),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                cardInfoModel.name,
                style: const TextStyle(fontSize: titleFontSize),
              ),
            ),
            subtitle: Text(
              cardInfoModel.description,
              style: const TextStyle(fontSize: paragraphFontSize),
            ),
          ),
          Consumer<ExerciseState>(builder: (context, exerciseState, child) {
            return Consumer<PageState>(builder: (context, pageState, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen),
                        onPressed: () =>
                            {openExercises(context, exerciseState, pageState)},
                        child: const Text(
                          "Start",
                          style: TextStyle(fontSize: buttonFontSize),
                        )),
                  ),
                ],
              );
            });
          })
        ],
      )),
    );
  }

  void openExercises(
      BuildContext context, ExerciseState exerciseState, PageState pageState) {
    var settings = Provider.of<SettingsState>(context, listen: false);

    if (!cardInfoModel
        .getSuitability()
        .contains(settings.level.toModel().description)) {
      showDialog(context: context, builder: (context) => AboveLevel(exerciseType: cardInfoModel.name));
    } else {
      exerciseState.exerciseType = cardInfoModel.name;
      pageState.isOnExercisePage = true;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const ExercisesPage();
      }));
    }
  }
}
