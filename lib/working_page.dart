import 'package:flutter/material.dart';
import './timer.dart';
import 'dart:async';

class WorkingPage extends StatelessWidget {
  final int data;
  const WorkingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: WorkingPageBody(data: data),
    );
  }
}

class WorkingPageBody extends StatefulWidget {
  final int data;
  const WorkingPageBody({super.key, required this.data});

  @override
  State<WorkingPageBody> createState() => _WorkingPageBodyState();
}

class _WorkingPageBodyState extends State<WorkingPageBody> {
  late int _initialMinutes;
  late Timer? _timer;
  bool _timerState = true;
  late String _minutes = "";
  late String _second = "";

  late int count = 0;

  PomodoroTimer _pomodoroTimer = PomodoroTimer();

  void _updateTime(Timer timer) {
    String _currentMinutes =
        _pomodoroTimer.getCurrentMinutes().toString().padLeft(2, "0");
    String _currentSeconds =
        _pomodoroTimer.getCurrentSeconds().toString().padLeft(2, "0");
    if (_currentMinutes == "00" && _currentSeconds == "00") {
      _pomodoroTimer.stopTimer();
      timer.cancel();
      count++;
      if (count >= 4) {
        count = 0;
        Navigator.pushNamed(context, "/rest",
            arguments: {"data": _initialMinutes}).then(
          (value) {
            _pomodoroTimer = PomodoroTimer();
            _pomodoroTimer.startTimer(_initialMinutes, TimerState.working);
            timer = Timer.periodic(const Duration(seconds: 0), _updateTime);
            print("count: $count");
          },
        );
      } else {
        Navigator.pushNamed(context, "/break",
            arguments: {"data": _initialMinutes}).then(
          (value) {
            _pomodoroTimer = PomodoroTimer();
            _pomodoroTimer.startTimer(_initialMinutes, TimerState.working);
            timer = Timer.periodic(const Duration(seconds: 0), _updateTime);
            print("count: $count");
          },
        );
      }
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
    _pomodoroTimer.startTimer(_initialMinutes, TimerState.working);
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _pomodoroTimer.resetTimer();
                    _timer?.cancel();
                    count = 0;
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_left,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 32,
                  ),
                ),
                Text(
                  "Working",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    height: 0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _pomodoroTimer.resetTimer();
                    _timer?.cancel();
                    count++;
                    if (count >= 4) {
                      count = 0;
                      Navigator.pushNamed(context, "/rest",
                          arguments: {"data": _initialMinutes}).then(
                        (value) {
                          _pomodoroTimer = PomodoroTimer();
                          _pomodoroTimer.startTimer(
                              _initialMinutes, TimerState.working);
                          _timer = Timer.periodic(
                              const Duration(seconds: 0), _updateTime);
                          setState(() {
                            _timerState = true;
                          });
                          print("count: $count");
                        },
                      );
                    } else {
                      Navigator.pushNamed(context, "/break",
                          arguments: {"data": _initialMinutes}).then(
                        (value) {
                          _pomodoroTimer = PomodoroTimer();
                          _pomodoroTimer.startTimer(
                              _initialMinutes, TimerState.working);
                          _timer = Timer.periodic(
                              const Duration(seconds: 0), _updateTime);
                          setState(() {
                            _timerState = true;
                          });
                          print("count: $count");
                        },
                      );
                    }
                  },
                  icon: Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).colorScheme.secondary,
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
                color: const Color(0xffF06852),
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
                  _pomodoroTimer.startTimer(0, TimerState.working);
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
