import 'package:flutter/material.dart';
import 'package:flutter_pomodoro/padding.dart';
import 'dart:async';

import 'package:flutter_pomodoro/timer.dart';

class WorkingPage extends StatelessWidget {
  final int data;
  final String todo;
  const WorkingPage({super.key, required this.data, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: WorkingPageBody(data: data, todo: todo),
    );
  }
}

class WorkingPageBody extends StatefulWidget {
  final int data;
  final String todo;
  const WorkingPageBody({super.key, required this.data, required this.todo});

  @override
  State<WorkingPageBody> createState() => _WorkingPageBodyState();
}

class _WorkingPageBodyState extends State<WorkingPageBody> {
  late String _todo;
  late int _initialMinutes;
  late Timer? _changeTimerState;
  late String _minutes = "";
  late String _second = "";

  late int count = 0;

  PomodoroTimer _pomodoroTimer = PomodoroTimer();

  @override
  void initState() {
    super.initState();
    _initialMinutes = widget.data;
    _todo = widget.todo;
    _pomodoroTimer.startTimer(
        _initialMinutes, TimerState.working); // Pomodoroタイマーをスタートする
    _changeTimerState = Timer.periodic(const Duration(seconds: 1),
        _updateTime); // Pomodoroタイマーの値が変更されるように画面を再描写する。
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

  Future<void> _goToNextPage(BuildContext context) async {
    _resetAllTimer();
    count++;
    if (count >= 4) {
      count = 0;
      // Navigator.pushNamedをawaitで待機
      await Navigator.pushNamed(context, "/rest",
          arguments: {"data": _initialMinutes});
    } else {
      await Navigator.pushNamed(context, "/break",
          arguments: {"data": _initialMinutes});
    }
    // 新しいページから戻ってきた後の処理
    _pomodoroTimer = PomodoroTimer();
    _pomodoroTimer.startTimer(_initialMinutes, TimerState.working);
    _changeTimerState = Timer.periodic(const Duration(seconds: 1), _updateTime);
    setState(() {});
    print("count: $count");
  }

  void _goBackPage(BuildContext context) {
    _resetAllTimer();
    count = 0;
    Navigator.pop(context);
  }

  void _updateTime(Timer timer) {
    String _currentMinutes =
        _pomodoroTimer.getCurrentMinutes().toString().padLeft(2, "0");
    String _currentSeconds =
        _pomodoroTimer.getCurrentSeconds().toString().padLeft(2, "0");
    if (_currentMinutes == "00" && _currentSeconds == "00") {
      _goToNextPage(context);
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
              _todo,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            DefaultSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _goBackPage(context),
                  icon: Icon(
                    Icons.arrow_left,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 32,
                  ),
                ),
                Text(
                  "Working",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                IconButton(
                  onPressed: () {
                    _goToNextPage(context);
                  },
                  icon: Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).colorScheme.secondary,
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
                color: const Color(0xffF06852),
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
