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
      )
    ],
  );
}
