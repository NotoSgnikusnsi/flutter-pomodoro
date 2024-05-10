import 'package:flutter/material.dart';
import './timer.dart';
import 'dart:async';

class BreakingPage extends StatelessWidget {
  final int data;
  const BreakingPage({super.key, required this.data});

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
  late int _initialMinutes;
  late Timer? _timer;
  bool _timerState = true;
  late String _minutes = "";
  late String _second = "";

  final PomodoroTimer _pomodoroTimer = PomodoroTimer();

  void _updateTime(Timer) {
    String _currentMinutes =
        _pomodoroTimer.getCurrentMinutes().toString().padLeft(2, "0");
    String _currentSeconds =
        _pomodoroTimer.getCurrentSeconds().toString().padLeft(2, "0");
    if (_currentMinutes == "00" && _currentSeconds == "00") {
      _pomodoroTimer.stopTimer();
      _timer?.cancel();
      Navigator.pop(context);
    }

    setState(() {
      _minutes = _currentMinutes;
      _second = _currentSeconds;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialMinutes = widget.data;
    _pomodoroTimer.startTimer(_initialMinutes, TimerState.breaking);
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ポモドーロのアプリを作る",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 30,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(50.0),
              ),
              Text(
                "breaking",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
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
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 60,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_timerState) {
                    _pomodoroTimer.stopTimer();
                    _timerState = false;
                  } else {
                    _pomodoroTimer.startTimer(0, TimerState.breaking);
                    _timerState = true;
                  }
                },
                icon: Icon(
                  _timerState ? Icons.pause : Icons.play_arrow,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
