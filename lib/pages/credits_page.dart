import 'package:coursework_two/components/sun_salutations_app_bar.dart';
import 'package:coursework_two/models/credit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/firebase_service.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CreditModel>>(
        future: FirebaseService().getCredits(),
        builder: (context, snapshot) {
          var credits = snapshot.data!;
          return Scaffold(
            appBar: createAppBar('Credits', context),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: credits.length,
                itemBuilder: (BuildContext context, int index) {
                  var credit = credits[index];
                  return SizedBox(
                    height: 50,
                    child: Center(
                        child: Linkify(
                            onOpen: (link) async {
                              if (await canLaunch(link.url)) {
                                await launch(link.url);
                              } else {
                                throw 'Could not launch $link';
                              }
                            },
                            text: '${credit.description} by ${credit.url}')),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          );
        });
  }
}
