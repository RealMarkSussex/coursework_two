enum TimerSetting {
  noTimer,
  twentySeconds,
  fourtySeconds,
  oneMinute,
  twoMinutes
}

extension ParseToTimerValue on TimerSetting {
  int toNumber() {
    var timerMappings = <TimerSetting, int>{
      TimerSetting.noTimer: 0,
      TimerSetting.twentySeconds: 20,
      TimerSetting.fourtySeconds: 40,
      TimerSetting.oneMinute: 60,
      TimerSetting.twoMinutes: 120
    };

    return timerMappings[this]!;
  }
}
