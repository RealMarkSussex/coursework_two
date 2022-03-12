enum TimerSetting {
  noTimer,
  twentySeconds,
  fourtySeconds,
  oneMinute,
  twoMinutes
}

extension ParseToTimerValue on TimerSetting {
  int toInt() {
    var timerMappings = <TimerSetting, int>{
      TimerSetting.noTimer: 0,
      TimerSetting.twentySeconds: 1,
      TimerSetting.fourtySeconds: 40,
      TimerSetting.oneMinute: 60,
      TimerSetting.twoMinutes: 120
    };

    return timerMappings[this]!;
  }

  Map<TimerSetting, String> toStringMap() {
    return <TimerSetting, String>{
      TimerSetting.noTimer: "No timer",
      TimerSetting.twentySeconds: "Twenty seconds",
      TimerSetting.fourtySeconds: "Fourty seconds",
      TimerSetting.oneMinute: "One minute",
      TimerSetting.twoMinutes: "Two minutes"
    };
  }
}
