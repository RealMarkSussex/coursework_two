import 'package:flutter/material.dart';

class TimerInfoDialog extends StatelessWidget {
  const TimerInfoDialog({Key? key}) : super(key: key);
  static const paragraphSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Timer Settings Help'),
            const SizedBox(height: paragraphSpacing),
            const Text(
                'This is for automatically scrolling through the exercises without lifting a finger.'),
            const SizedBox(height: paragraphSpacing),
            const Align(
              child: Text(
                  'By default this is set to no timer meaning scrolling won\'t happen automatically.'),
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: paragraphSpacing),
            const Text(
                'If you decide to go at 20 seconds speed you will not have audio instructions.'),
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
