import 'package:coursework_two/components/page_card.dart';
import 'package:coursework_two/components/sun_salutations_app_bar.dart';
import 'package:coursework_two/dialogs/disclaimer_dialog.dart';
import 'package:coursework_two/dialogs/level_dialog.dart';
import 'package:coursework_two/models/card_info_model.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
              context: context, builder: (context) => const DisclaimerDialog())
          .then((value) => showDialog(
              context: context, builder: (context) => const LevelDialog()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CardInfoModel>>(
        future: FirebaseService().getCardInfoModel(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CardInfoModel>> snapshot) {
          var data = snapshot.data;
          data ??= [];
          return Scaffold(
              appBar: createAppBar('Sun Salutatons', context),
              body: Center(
                  child: ListView(
                scrollDirection: Axis.vertical,
                children: data.map((e) => PageCard(cardInfoModel: e)).toList(),
              )));
        });
  }
}
