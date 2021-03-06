import 'package:coursework_two/services/firebase_service.dart';
import 'package:coursework_two/state/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coursework_two/enums/level.dart';

class LevelDialog extends StatelessWidget {
  const LevelDialog({Key? key}) : super(key: key);
  static const paragraphSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Consumer<SettingsState>(builder: (context, settingsState, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: getWidgets(settingsState, context),
          );
        }),
      )
    ]);
  }

  List<Widget> getWidgets(SettingsState settingsState, BuildContext context) {
    List<Widget> widgets = [];
    widgets.add(const Text('Choose your skill level'));
    widgets.add(const SizedBox(height: paragraphSpacing));
    widgets.addAll(settingsState.level.toList().map(
          (levelModel) => TextButton(
            onPressed: () => {
              settingsState.level = levelModel.level,
              FirebaseService().storeLevelForUser(levelModel.level),
              Navigator.pop(context)
            },
            child: Text(levelModel.description),
          ),
        ));
    return widgets;
  }
}
