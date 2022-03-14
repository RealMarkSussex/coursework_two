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
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!;
              data.sort((setModelOne, setModelTwo) =>
                  setModelOne.date.compareTo(setModelTwo.date));
              List<charts.Series<dynamic, String>> series = [
                charts.Series(
                    id: "Sets",
                    data: data,
                    domainFn: (dynamic setModel, _) =>
                        (setModel.date.toString().substring(0, 11)),
                    measureFn: (dynamic setModel, _) => setModel.numberOfSets)
              ];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Number of Sets by Day",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: charts.BarChart(series, animate: true),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
