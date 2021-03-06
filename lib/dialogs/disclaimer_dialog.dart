import 'package:coursework_two/dialogs/level_dialog.dart';
import 'package:coursework_two/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DisclaimerDialog extends StatelessWidget {
  const DisclaimerDialog({Key? key}) : super(key: key);

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
              width: 20.0,
            ),
            Text('Disclaimer'),
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
                          'The practitioner knows that the practice is their responsibility and they should consult their GP before doing any of these physical practices. The app developer is not responsible for any injuries'),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => onIDontLikeThisPressed(context),
                      child: const Text('I do not like this!'),
                    ),
                    TextButton(
                      onPressed: () => onOkPressed(context),
                      child: const Text('Ok'),
                    )
                  ],
                )
              ],
            ),
          ),
        ]);
  }

  Future<void> onOkPressed(BuildContext context) async {
    await FirebaseService().storeConsentForUser(true, "disclaimer");
    Navigator.pop(context);
  }

  Future<void> onIDontLikeThisPressed(BuildContext context) async {
    await FirebaseService().storeConsentForUser(false, "disclaimer");
    Navigator.pop(context);
  }
}
