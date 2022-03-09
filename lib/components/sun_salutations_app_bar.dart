import 'package:coursework_two/dialogs/settings_dialog.dart';
import 'package:coursework_two/enums/timer_setting.dart';
import 'package:coursework_two/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar createAppBar(String title, BuildContext context,
    Function(TimerSetting?, AppState)? callback) {
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
              context: context,
              builder: (context) => SettingsDialog(
                    callback: callback,
                  ));
        },
      ),
    ],
  );
}
