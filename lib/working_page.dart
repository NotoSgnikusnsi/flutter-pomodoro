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
  late String _minutes = "00";
  late String _second = "00";

  final PomodoroTimer _pomodoroTimer = PomodoroTimer();

  void _updateTime(Timer) {
    String _currentMinutes =
        _pomodoroTimer.getCurrentMinutes().toString().padLeft(2, "0");
    String _currentSeconds =
        _pomodoroTimer.getCurrentSeconds().toString().padLeft(2, "0");

    setState(() {
      _minutes = _currentMinutes;
      _second = _currentSeconds;
    });
  }

  @override
  void initState() {
    super.initState();
    var _data = widget.data;
    _pomodoroTimer.startTimer(_data, TimerState.working);
    Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SizedBox(
          width: 400,
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
                "Working",
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
                width: 400,
                height: 200,
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
                onPressed: null,
                icon: Icon(
                  Icons.pause,
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
