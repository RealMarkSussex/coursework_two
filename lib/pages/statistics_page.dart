import 'package:coursework_two/components/sun_salutations_app_bar.dart';
import 'package:coursework_two/models/set_model.dart';
import 'package:coursework_two/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("Statistics", context),
      body: FutureBuilder<List<SetModel>>(
          future: FirebaseService().getSetsForUser(),
          builder: (context, snapshot) {
            var data = snapshot.data!;

            var series = [
              charts.Series(
                  id: "Sets",
                  data: data,
                  domainFn: (setModel, value) => null,
                  measureFn: (setModel, value) => null)
            ];
            return Column();
          }),
    );
  }
}
