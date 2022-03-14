import 'package:flutter/material.dart';

class SetInfoDialog extends StatelessWidget {
  const SetInfoDialog({Key? key}) : super(key: key);
  static const paragraphSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Set Settings Help'),
            const SizedBox(height: paragraphSpacing),
            const Text(
                'This must be used in conjunction with the timer setting.'),
            const SizedBox(height: paragraphSpacing),
            const Text('Sets will be recorded in the statistics page.'),
            const SizedBox(height: paragraphSpacing),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      )
    ]);
  }
}
