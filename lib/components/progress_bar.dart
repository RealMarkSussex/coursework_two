import 'package:coursework_two/enums/timer_setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/settings_state.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with TickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );

  @override
  void initState() {
    var settingsState = Provider.of<SettingsState>(context, listen: false);
    var timerValue = settingsState.timerSetting.toInt();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: timerValue == 0 ? 5 : timerValue),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsState>(builder: (context, settingsState, child) {
      return settingsState.timerSetting != TimerSetting.noTimer
          ? LinearProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            )
          : const SizedBox.shrink();
    });
  }
}
