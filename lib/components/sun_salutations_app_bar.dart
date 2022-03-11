import 'package:coursework_two/dialogs/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar createAppBar(String title, BuildContext context) {
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.deepOrange,
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.infoCircle),
        tooltip: 'About',
        onPressed: () {
          Navigator.pushNamed(context, '/about');
        },
      ),
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.wrench),
        tooltip: 'Settings',
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const SettingsDialog());
        },
      ),
      IconButton(
          icon: const FaIcon(FontAwesomeIcons.comment),
          tooltip: 'Leave a comment',
          onPressed: () {
            Navigator.pushNamed(context, '/comment');
          }),
      IconButton(
          icon: const FaIcon(FontAwesomeIcons.creditCard),
          tooltip: 'Credits',
          onPressed: () {
            Navigator.pushNamed(context, '/credits');
          })
    ],
  );
}
