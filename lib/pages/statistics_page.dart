import 'package:coursework_two/components/sun_salutations_app_bar.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar("Statistics", context),
      body: Column(),
    );
  }
}
