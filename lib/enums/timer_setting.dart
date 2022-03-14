enum TimerSetting {
  noTimer,
  tenSeconds,
  twentySeconds,
  fourtySeconds,
  oneMinute,
  twoMinutes
}

extension Parser on TimerSetting {
  int toInt() {
    var timerMappings = <TimerSetting, int>{
      TimerSetting.noTimer: 0,
      TimerSetting.tenSeconds: 10,
      TimerSetting.twentySeconds: 20,
      TimerSetting.fourtySeconds: 40,
      TimerSetting.oneMinute: 60,
      TimerSetting.twoMinutes: 120
    };

    return timerMappings[this]!;
  }

  List<TimerSettingModel> toList() {
    return [
      TimerSettingModel(
          timerSetting: TimerSetting.noTimer, description: "No timer"),
      TimerSettingModel(
          timerSetting: TimerSetting.tenSeconds, description: "10 seconds"),
      TimerSettingModel(
          timerSetting: TimerSetting.twentySeconds, description: "20 Seconds"),
      TimerSettingModel(
          timerSetting: TimerSetting.fourtySeconds, description: "40 seconds"),
      TimerSettingModel(
          timerSetting: TimerSetting.oneMinute, description: "1 minute"),
      TimerSettingModel(
          timerSetting: TimerSetting.twoMinutes, description: "2 minutes"),
    ];
  }
}

class TimerSettingModel {
  final TimerSetting timerSetting;
  final String description;

  TimerSettingModel({required this.timerSetting, required this.description});
}
