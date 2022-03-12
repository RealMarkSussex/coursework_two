enum SetSetting {
  noSets,
  fourSets,
  eigtSets,
  twelveSets,
  sixteenSets,
  twentySets,
  twentyFourSets,
  thirtySixSets,
  fourtyEightSets,
  fiftyFourSets
}

extension Parser on SetSetting {
  int toInt() {
    var numberOfSetsMapping = <SetSetting, int>{
      SetSetting.noSets: 0,
      SetSetting.fourSets: 4,
      SetSetting.eigtSets: 8,
      SetSetting.twelveSets: 12,
      SetSetting.sixteenSets: 16,
      SetSetting.twentySets: 20,
      SetSetting.twentyFourSets: 24,
      SetSetting.thirtySixSets: 36,
      SetSetting.fourtyEightSets: 48,
      SetSetting.fiftyFourSets: 54,
    };

    return numberOfSetsMapping[this]!;
  }

  List<SetSettingModel> toList() {
    return [
      SetSettingModel(setSetting: SetSetting.noSets, description: "No sets"),
      SetSettingModel(setSetting: SetSetting.fourSets, description: "4 sets"),
      SetSettingModel(setSetting: SetSetting.eigtSets, description: "8 sets"),
      SetSettingModel(
          setSetting: SetSetting.twelveSets, description: "12 sets"),
      SetSettingModel(
          setSetting: SetSetting.sixteenSets, description: "16 sets"),
      SetSettingModel(
          setSetting: SetSetting.twentySets, description: "20 sets"),
      SetSettingModel(
          setSetting: SetSetting.twentyFourSets, description: "24 sets"),
      SetSettingModel(
          setSetting: SetSetting.thirtySixSets, description: "36 sets"),
      SetSettingModel(
          setSetting: SetSetting.fourtyEightSets, description: "48 sets"),
      SetSettingModel(
          setSetting: SetSetting.fiftyFourSets, description: "54 sets"),
    ];
  }
}

class SetSettingModel {
  final SetSetting setSetting;
  final String description;

  SetSettingModel({required this.setSetting, required this.description});
}
