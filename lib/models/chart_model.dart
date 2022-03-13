import 'set_model.dart';

class ChartModel {
  int day;
  int numberOfSets;

  ChartModel({required this.day, required this.numberOfSets});

  ChartModel.fromSetModel(List<SetModel> setModel)
      : this(day: 1, numberOfSets: 1);
}
