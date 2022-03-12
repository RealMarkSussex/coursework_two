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

extension ParseToNumberOfSets on SetSetting {
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
}
