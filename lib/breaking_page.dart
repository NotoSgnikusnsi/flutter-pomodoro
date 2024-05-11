import 'package:flutter/material.dart';
import 'package:flutter_pomodoro/padding.dart';
import 'dart:async';

import 'package:flutter_pomodoro/timer.dart';

class BreakingPage extends StatelessWidget {
  final int data;
  const BreakingPage({super.key, required this.data, required todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: BreakingPageBody(data: data),
    );
  }
}

class BreakingPageBody extends StatefulWidget {
  final int data;
  const BreakingPageBody({super.key, required this.data});

  @override
  State<BreakingPageBody> createState() => _BreakingPageBodyState();
}

class _BreakingPageBodyState extends State<BreakingPageBody> {
  late String _todo;
  late int _initialMinutes;
  late Timer? _changeTimerState;
  late String _minutes = "";
  late String _second = "";

  final PomodoroTimer _pomodoroTimer = PomodoroTimer();

  @override
  void initState() {
    super.initState();
    _initialMinutes = widget.data;
    _pomodoroTimer.startTimer(_initialMinutes, TimerState.breaking);
    _changeTimerState = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  @override
  void dispose() {
    _pomodoroTimer.resetTimer();
    _changeTimerState?.cancel();
    super.dispose();
  }

  void _setTimerState() {
    if (_changeTimerState!.isActive) {
      _pomodoroTimer.stopTimer();
      _changeTimerState?.cancel();
    } else {
      _pomodoroTimer.startTimer(0, TimerState.working);
      _changeTimerState =
          Timer.periodic(const Duration(seconds: 1), _updateTime);
    }

    setState(() {});
  }

  void _resetAllTimer() {
    _pomodoroTimer.resetTimer();
    _changeTimerState?.cancel();
  }

  void _goBackPage(BuildContext context) {
    _resetAllTimer();
    Navigator.pop(context);
  }

  void _updateTime(Timer timer) {
    String _currentMinutes =
        _pomodoroTimer.getCurrentMinutes().toString().padLeft(2, "0");
    String _currentSeconds =
        _pomodoroTimer.getCurrentSeconds().toString().padLeft(2, "0");
    if (_currentMinutes == "00" && _currentSeconds == "00") {
      _goBackPage(context);
    }

    setState(() {
      _minutes = _currentMinutes;
      _second = _currentSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ポモドーロのアプリを作る",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            DefaultSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _goBackPage(context);
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 32,
                  ),
                ),
                Text(
                  "Breaking",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 32,
                  ),
                ),
              ],
            ),
            DefaultSpace(),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: const Color(0xff518DF0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "$_minutes:$_second",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _setTimerState();
              },
              icon: Icon(
                _changeTimerState!.isActive ? Icons.pause : Icons.play_arrow,
                color: Theme.of(context).colorScheme.secondary,
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
