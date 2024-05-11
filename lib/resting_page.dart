import 'package:flutter/material.dart';
import './timer.dart';
import 'dart:async';

class RestingPage extends StatelessWidget {
  final int data;
  const RestingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: RestingPageBody(data: data),
    );
  }
}

class RestingPageBody extends StatefulWidget {
  final int data;
  const RestingPageBody({super.key, required this.data});

  @override
  State<RestingPageBody> createState() => _RestingPageBodyState();
}

class _RestingPageBodyState extends State<RestingPageBody> {
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
    _pomodoroTimer.startTimer(_initialMinutes, TimerState.resting);
    _timer = Timer.periodic(const Duration(seconds: 0), _updateTime);
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
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                height: 0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(50.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _pomodoroTimer.resetTimer();
                    _timer?.cancel();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 32,
                  ),
                ),
                Text(
                  "Resting",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    height: 0,
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
            const Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: const Color(0xffC5F051),
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
                  _pomodoroTimer.startTimer(0, TimerState.resting);
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
    );
  }
}
